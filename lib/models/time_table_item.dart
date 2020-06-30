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
  final TimeOfDay time;
  final List<Day> days;

  TimetableItem({this.title, this.time, this.days});
}