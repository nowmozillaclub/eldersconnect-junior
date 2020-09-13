import 'package:ec_junior/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTableProvider with ChangeNotifier {
  final User _mainUser;
  final User _senior;

  final Firestore _firestore = Firestore.instance;

  final Map<Day, List<TimetableItem>> _timetableList = {
    Day.Mon: [],
    Day.Tue: [],
    Day.Wed: [],
    Day.Thur: [],
    Day.Fri: [],
    Day.Sat: [],
    Day.Sun: [],
  };

  final Function setupUser;
  final Function updateTimetableId;

  TimeTableProvider(
    this._mainUser,
    this._senior,
    this.setupUser,
    this.updateTimetableId,
  );

  /// Fetching timetable documents from the
  /// cloud firestore and also segregating
  /// it on day basis.
  Future<void> fetchTimeTable() async {
    // Getting names of days in a week.
    List<String> days = this
        ._timetableList
        .keys
        .map((day) => this._convertDayToString(day))
        .toList();

    // CASE 1: If User is not logged in or
    // does not have timetableId already.
    if ((_mainUser == null && _senior == null) ||
        (_mainUser.timetableId == null && _senior.timetableId == null)) {
      return;
    }

    // CASE 2: If timetableId exists on the user object.
    else {
      // Emptying the lists in each key value pair.
      _timetableList.forEach((key, value) {
        value.removeRange(0, value.length);
      });

      // Getting a reference to the main
      // document in the timetable collection
      DocumentReference documentReference = this
          ._firestore
          .collection("timetable")
          .document(this._mainUser.timetableId);

      // Looping over to fetch documents by days.
      for (String day in days) {
        // Getting Day enum for the looping day string.
        Day key = this._convertStringToDay(day);

        // Getting all documents in the day sub-collection.
        List<DocumentSnapshot> documents =
            (await documentReference.collection(day).getDocuments()).documents;

        // Looping over each document to convert it into
        // TimetableItems.
        for (DocumentSnapshot document in documents) {
          Map<String, dynamic> data = document.data;

          // TimetableItem object respective to the document.
          TimetableItem timetableItem = new TimetableItem(
            uid: document.documentID,
            time: data['time'],
            title: data['title'],
          );

          // Adding the document to the timetableList.
          this._timetableList[key].add(timetableItem);
        }
      }
    }
  }

  /// Getter for the timetable list.
  Map<Day, List<TimetableItem>> get getTimetable => {...this._timetableList};

  /// Adding the given timetable record to the firestore.
  Future<void> addTimetable(TimetableItem timetableItem) async {
    try {
      // CASE 1: If timetableId does not exist.
      if (_mainUser.timetableId == null && _senior.timetableId == null) {
        // Creating the main timetable document in the cloud firestore.
        DocumentReference timetableDocRef =
            await _firestore.collection('timetable').add({
          "juniorId": _mainUser.uid,
          "seniorId": _senior.uid,
        });

        // Getting the list of days this timetable record belongs to.
        List<Day> days = timetableItem.days;

        // Looping over the days to add the timetable
        // to the respective day sub-collection.
        for (Day day in days) {
          // Getting the string value for the day enum.
          String dayString = this._convertDayToString(day);

          // Creating the document in the day sub-collection.
          DocumentReference documentReference =
              await timetableDocRef.collection(dayString).add({
            'title': timetableItem.title,
            'time': timetableItem.time,
          });

          // Creating a new timetableItem object for
          // the timetableRecord.
          TimetableItem newTimeTableItem = new TimetableItem(
            title: timetableItem.title,
            time: timetableItem.time,
            uid: documentReference.documentID,
          );

          // Adding the timetableItem to the timetable list.
          this._timetableList[day].add(newTimeTableItem);
        }

        // Update the new timetableId for both junior and senior reference.
        await updateTimetableId(timetableDocRef.documentID);
      }

      // CASE 2: If timetableId exists.
      else {
        // Getting the list of days this timetable record belongs to.
        List<Day> days = timetableItem.days;

        // Looping over the days to add the timetable
        // to the respective day sub-collection.
        for (Day day in days) {
          // Getting the string value for the day enum.
          String dayString = this._convertDayToString(day);

          // Creating the document in the day sub-collection.
          DocumentReference documentReference = await _firestore
              .collection('timetable')
              .document(_mainUser.timetableId)
              .collection(dayString)
              .add({
            'title': timetableItem.title,
            'time': timetableItem.time,
          });

          // Creating a new timetableItem object for
          // the timetableRecord.
          TimetableItem newTimeTableItem = new TimetableItem(
            title: timetableItem.title,
            time: timetableItem.time,
            days: timetableItem.days,
            uid: documentReference.documentID,
          );

          // Adding the timetableItem to the timetable list.
          this._timetableList[day].add(newTimeTableItem);
        }

        // Refresh the in-memory user.
        setupUser();
      }
    } catch (error) {
      print(error);
    }
  }

  //TODO: Complete delete functionality.
  Future<void> deleteTimeTableItem(TimetableItem item) async {
    await this
        ._firestore
        .collection("timetable")
        .document(_mainUser.timetableId)
        .collection("timetable")
        .document(item.uid)
        .delete();

//    _timetableList.removeWhere((element) => element.uid == item.uid);
  }

  /// Convert String to Day Enum.
  Day _convertStringToDay(String day) {
    switch (day) {
      case "Mon":
        return Day.Mon;
      case "Tue":
        return Day.Tue;
      case "Wed":
        return Day.Wed;
      case "Thur":
        return Day.Thur;
      case "Fri":
        return Day.Fri;
      case "Sat":
        return Day.Sat;
      case "Sun":
        return Day.Sun;
      default:
        return Day.Mon;
    }
  }

  // Convert Day enum to String.
  String _convertDayToString(Day day) {
    return day.toString().split('.').last;
  }
}
