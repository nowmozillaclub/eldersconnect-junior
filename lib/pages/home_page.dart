import 'dart:convert';

import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/ui_helpers.dart';
import 'package:ec_junior/widgets/senior_details.dart';
import 'package:ec_junior/widgets/senior_logs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = Provider.of<SharedPreferences>(context);
    final _user = User.fromJson(json.decode(_prefs.getString('user')));
    final _seniorUser = User(
      uid: 'something',
      name: 'Senior Varun Khatri',
    );
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
              color: isThemeCurrentlyDark(context)
                  ? Colors.white
                  : MyColors.primary,
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
      )),
    );
  }
}
