import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _pickedTime;
  String task = '';
  final Map<String, String> someMap = {};

  Future<Null> selectTime(BuildContext context) async {
    _pickedTime = await showTimePicker(context: context, initialTime: _time);
    setState(() {});
  }

  void _saveTimetable() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    final DocumentSnapshot junior = await Firestore.instance
        .collection('juniors')
        .document(currentUser.uid)
        .get();
    someMap[_pickedTime.format(context).toString()] = task;
    Firestore.instance
        .collection('timetable')
        .document(currentUser.uid)
        .updateData({
      'juniorId': currentUser.uid,
      'seniorId': junior['connectedToUid'],
      'timetable': someMap,
    });
    print(task);
    print(someMap);
    print(_pickedTime.toString());
    Navigator.of(context).pop();
  }

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
                    onPressed: _saveTimetable,
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
