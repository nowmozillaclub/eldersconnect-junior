import 'package:flutter/material.dart';

enum Day {
  Mon,
  Tue,
  Wed,
  Thur,
  Fri,
  Sat,
  Sun,
}

class TimetableItem {
  final String title;
  final String time;
  final List<dynamic> days;

  TimetableItem({this.title, this.time, this.days});
}