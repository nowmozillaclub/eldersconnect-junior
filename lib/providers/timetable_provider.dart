import 'package:ec_junior/models/models.dart';
import 'package:ec_junior/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class TimeTableProvider with ChangeNotifier {
  final User _mainUser;
  final User _senior;
  final Firestore _firestore = Firestore.instance;
  List<TimetableItem> _timetableList=[];

  TimeTableProvider(this._mainUser, this._senior) {
    getTimeTable();
    print("constructor");
  }

  Future<void> getTimeTable() async{
    if(_mainUser == null && _senior == null){
      return;
    }
  else if(_mainUser.timetableId != null && _senior.timetableId!=null){
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
        print(element['title']);
      });
    }
  }

  Future<void> addTimetable(TimetableItem timetableItem) async {
    try {
      print(_mainUser.timetableId == null);
      print(_senior.timetableId==null);
      print(_mainUser.timetableId);

      if (_mainUser.timetableId == null && _senior.timetableId == null) {
        List<TimetableItem> timetableList = [];
        timetableList.add(timetableItem);
        print(timetableList);

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
        await UserProvider().updateTimetableId(timetableDocRef.documentID);
        // constructor is not called even though there is notifylistener() inside updateTimetableId()
      } else {
        print("inside else");
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
        this._timetableList.add(timetableItem);
        await this
            ._firestore
            .collection("timetable")
            .document(_mainUser.timetableId)
            .updateData({
          "timetable": currentTimetable,
        });
      }
    } catch (error) {
      print(error);
    }
  }

}
