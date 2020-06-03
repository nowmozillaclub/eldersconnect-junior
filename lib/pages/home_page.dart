import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/widgets/senior_details.dart';
import 'package:ec_junior/widgets/senior_logs.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> seniorLogs = {
      'Today': {
        '8:00AM': 'Took Medicines',
        '9:00AM': 'Walked for 35 minutes',
        '10:00AM': 'Had breakfast',
        '12:00PM': 'Had Lunch'
      },
      'Yesterday': {
        '8:00AM': 'Took Medicines',
        '9:00AM': 'Walked for 35 minutes',
        '10:00AM': 'Had breakfast',
        '12:00PM': 'Had Lunch'
      },
      'tomorrow': {
        '8:00AM': 'Took Medicines',
        '9:00AM': 'Walked for 35 minutes',
        '10:00AM': 'Had breakfast',
        '12:00PM': 'Had Lunch'
      },
      'tomorow': {
        '8:00AM': 'Took Medicines',
        '9:00AM': 'Walked for 35 minutes',
        '10:00AM': 'Had breakfast',
        '12:00PM': 'Had Lunch'
      },
    };

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff212121),
        body: Container(
          child: ListView(
            children: <Widget>[
              SeniorDetails(),
              SeniorLogs(seniorlogs: seniorLogs),
            ],
          ),
        ),
      ),
    );
  }
}
