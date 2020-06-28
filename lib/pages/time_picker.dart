import 'dart:async';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _pickedTime;
  String task = '';
  final _formKey = GlobalKey<FormState>();

  Future<Null> selectTime(BuildContext context) async {
    _pickedTime = await showTimePicker(context: context, initialTime: _time);
    setState(() {});
  }

  void saveForm() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
//      Timer(Duration(seconds: 1), () {
//      });
      Navigator.of(context).pop();
    }
  }

  Widget timetableInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a task. This cannot be left blank";
                  }
                  return null;
                },
                key: ValueKey("task"),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Task"),
                onSaved: (value) {
                  task = value;
                },
              ),
              TextFormField(
                key: ValueKey("description"),
                keyboardType: TextInputType.text,
                decoration:
                    InputDecoration(labelText: "Task Description( optional)"),
                onSaved: (value) {
                  task = value;
                },
              ),
            ],
          ),
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
                    onPressed: saveForm,
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
