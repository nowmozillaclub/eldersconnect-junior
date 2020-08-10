import 'package:ec_junior/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTableProvider with ChangeNotifier {
  final User _mainUser;
  final User _senior;
  final Firestore _firestore = Firestore.instance;
  static List<TimetableItem> _timetableList = [];
  final Function setupUser;
  final Function updateTimetableId;

  TimeTableProvider(
      this._mainUser, this._senior, this.setupUser, this.updateTimetableId) {
    getTimeTable();
  }

  Future<void> getTimeTable() async {
    if (_mainUser == null && _senior == null) {
      return;
    } else if (_mainUser.timetableId != null && _senior.timetableId != null) {
      final DocumentSnapshot timeTableDocSnap = await this
          ._firestore
          .collection("timetable")
          .document(_mainUser.timetableId)
          .get();

      List<dynamic> timetable = await timeTableDocSnap.data["timetable"];

      timetable.forEach((element) {
        TimetableItem timetableItem = new TimetableItem(
          title: element["title"],
          days: element["days"],
          time: element["time"],
        );

        _timetableList.add(timetableItem);
      });
    }
  }

  Future<void> addTimetable(TimetableItem timetableItem) async {
    try {
      if (_mainUser.timetableId == null && _senior.timetableId == null) {
        List<TimetableItem> timetableList = [];
        timetableList.add(timetableItem);
        DocumentReference timetableDocRef =
            await _firestore.collection('timetable').add({
          "juniorId": _mainUser.uid,
          "seniorId": _senior.uid,
          "timetable": [
            {
              'days': timetableItem.days,
              'title': timetableItem.title,
              'time': timetableItem.time
            }
          ],
        });
        await updateTimetableId(timetableDocRef.documentID);
      } else {
        DocumentSnapshot currentTimetableDoc = await _firestore
            .collection('timetable')
            .document(_mainUser.timetableId)
            .get();
        List<dynamic> currentTimetable = currentTimetableDoc.data['timetable'];
        currentTimetable.add({
          'days': timetableItem.days,
          'title': timetableItem.title,
          'time': timetableItem.time
        });
        _timetableList.add(timetableItem);
        await this
            ._firestore
            .collection("timetable")
            .document(_mainUser.timetableId)
            .updateData({
          "timetable": currentTimetable,
        });

        setupUser();
      }
      await _firestore.collection('timetable').document(_mainUser.timetableId).updateData({
        "timestamp": '${DateTime.now().hour}:${DateTime.now().minute}',
      });
    } catch (error) {
      print(error);
    }
  }

  void deleteTimeTabelItem(TimetableItem item) async {
    DocumentSnapshot doc = await _firestore
        .collection('timetable')
        .document(_mainUser.timetableId)
        .get();
    List<dynamic> currTimetable = doc.data['timetable'];
    currTimetable.removeWhere((element) => element['title'] == item.title);
    print(currTimetable.length);
    await _firestore
        .collection('timetable')
        .document(_mainUser.timetableId)
        .updateData({'timetable': currTimetable});
    _timetableList.removeWhere((element) => element.title == item.title);
  }
}
