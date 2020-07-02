import 'package:flutter/material.dart';

enum Day {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

class TimetableItem {
  final String title;
  final String time;
  final List<dynamic> days;

  TimetableItem({this.title, this.time, this.days});
}