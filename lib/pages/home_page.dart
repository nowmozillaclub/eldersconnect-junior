import 'dart:convert';

import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/ui_helpers.dart';
import 'package:ec_junior/widgets/senior_details.dart';
import 'package:ec_junior/widgets/senior_logs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  final SharedPreferences prefs;

  MyHomePage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User _user = User.fromJson(json.decode(prefs.getString('user')));
    final User _seniorUser = User(uuid: 'something',
                                  name: 'Senior Varun Khatri');
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

    };

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Text(
              'EldersConnect',
              style: TextStyle(
                color: isThemeCurrentlyDark(context) ? Colors.white:MyColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SeniorDetails(

              seniorUser: _seniorUser,

            ),
            SeniorLogs(
              seniorlogs: seniorLogs,
            ),
          ],
        )
      ),
    );
  }
}
