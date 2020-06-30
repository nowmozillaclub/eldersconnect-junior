import 'package:ec_junior/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTableProvider with ChangeNotifier {
  final User _mainUser;
  final User _senior;
  final Firestore _firestore = Firestore.instance;
  List<TimetableItem> _timetableList;

  TimeTableProvider(this._mainUser, this._senior) {
    getTimeTable();
  }

  Future<void> getTimeTable() async {
    if (_mainUser.timetableId == null && _senior.timetableId == null) {
      this._timetableList = [];
    } else {
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

        this._timetableList.add(timetableItem);
      });
    }
  }

  Future<void> addTimetable(TimetableItem timetableItem) async {
    try {
      if (_mainUser.timetableId == null && _senior.timetableId == null) {
        List<TimetableItem> timetableList = [];

        timetableList.add(timetableItem);

        DocumentReference timetableDocRef =  await _firestore.collection('timetable').add({
          "juniorId": _mainUser.uid,
          "seniorId": _senior.uid,
          "timetable": timetableList,
        });

        await this
            ._firestore
            .collection("juniors")
            .document(_mainUser.uid)
            .updateData({
          "timetableId": timetableDocRef.documentID,
        });

        await this
            ._firestore
            .collection("seniors")
            .document(_senior.uid)
            .updateData({
          "timetableId": timetableDocRef.documentID,
        });

      } else {
        this._timetableList.add(timetableItem);

        await this
            ._firestore
            .collection("timetable")
            .document(_mainUser.timetableId)
            .updateData({
          "timetable": _timetableList,
        });
      }
    } catch (error) {
      print(error);
    }
  }
}
