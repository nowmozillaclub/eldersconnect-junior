import 'day.dart';

class TimetableItem {
  final String uid;
  final String title;
  final String time;
  final List<Day> days;

  TimetableItem({this.title, this.time, this.days, this.uid = ''});
}