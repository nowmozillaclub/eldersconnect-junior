import 'dart:async';
import 'package:ec_junior/models/models.dart';

import '../providers/timetable_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _pickedTime;
  String task = '';
  Map<String, dynamic> timetables = {};

  Future<Null> selectTime(BuildContext context) async {
    _pickedTime = await showTimePicker(context: context, initialTime: _time);
    setState(() {});
  }

//  void _saveTimetable() async {
//    UserProvider userprovider= UserProvider();
//    User user = await userprovider.user;
//    print(timetables);
//    timetables[_pickedTime.format(context).toString()] = task;
//    Firestore.instance
//        .collection('timetable')
//        .document(user.uid)
//        .setData({
//      'juniorId': user.uid,
//      'seniorId': user.connectedToUid,
//      'timetable': timetables,
//    });
//    print(timetables);
//    Navigator.of(context).pop();
//  }

  Widget timetableInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[700], width: 3),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TextField(
          key: ValueKey("task"),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: "Task"),
          onChanged: (value) {
            setState(() {
              task = value;
            });
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final timetableProvider= Provider.of<TimeTableProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              ClipRRect(
                child: Image.asset('assets/icon/timerimg.jpeg'),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              timetableInput(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    child: Text(
                      _pickedTime == null
                          ? "Set Time"
                          : _pickedTime.format(context).toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      selectTime(context);
                      print(_pickedTime.toString());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: (){
                      TimetableItem timetableitem = TimetableItem(title: task, days: ["Monday"], time: _pickedTime.format(context).toString());
                      timetableProvider.addTimetable(timetableitem);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
