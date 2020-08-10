import 'dart:async';
import 'package:analog_clock/analog_clock.dart';
import 'package:ec_junior/models/models.dart';
import 'package:ec_junior/widgets/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ec_junior/providers/providers.dart';

class TimePicker extends StatefulWidget {
  static final String routeName = "/time-picker";

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _pickedTime;
  String task = '';
  List<String> days = [];
  Map<String, dynamic> timetables = {};
  List<bool> tapped = List.filled(7, false);
  final taskController = TextEditingController();

  Future<Null> selectTime(BuildContext context) async {
    _pickedTime = await showTimePicker(context: context, initialTime: _time);
    setState(() {});
  }

  void onTapOfCheckBox(int index) {
    days.add(daysOfWeek[index]);
  }

  List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  void dispose() {
    taskController.dispose();
    super.dispose();
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
          controller: taskController,
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

  Widget showDayPicker() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: daysOfWeek.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Container(
                child: RawMaterialButton(
                  onPressed: () {
                    onTapOfCheckBox(index);
                    setState(() {
                      tapped[index] = !tapped[index];
                    });
                  },
                  elevation: 3.0,
                  fillColor: Color.fromRGBO(100, 220, 180, 0.2),
                  child: FittedBox(
                    child: tapped[index]? Text("${daysOfWeek[index]}",style: TextStyle(color: Colors.amber),): Text("${daysOfWeek[index]}"),
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                //TODO: OnTap function of check box
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timetableProvider = Provider.of<TimeTableProvider>(context);
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Set Senior Timetable'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AnalogClock(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.black),
                      color: Colors.purple.withOpacity(0.4),
                      shape: BoxShape.circle),
                  width: 150.0,
                  isLive: true,
                  hourHandColor: Colors.white,
                  minuteHandColor: Colors.white,
                  showSecondHand: true,
                  secondHandColor: Colors.red,
                  numberColor: Colors.amber,
                  showNumbers: true,
                  textScaleFactor: 2.0,
                  showTicks: false,
                  showDigitalClock: true,
                  datetime: DateTime.now(),
                ),
                timetableInput(),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  splashColor: Colors.amber,
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    _pickedTime == null
                        ? "Set Time"
                        : _pickedTime.format(context).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () {
                    selectTime(context);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                showDayPicker(),
                InkWell(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text("Save"),
                    alignment: Alignment.center,
                  ),
                  onTap: () {
                    TimetableItem timetableitem = TimetableItem(
                        title: task,
                        days: days,
                        time: _pickedTime.format(context));
                    timetableProvider.addTimetable(timetableitem);
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
