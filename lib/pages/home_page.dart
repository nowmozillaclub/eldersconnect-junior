import 'dart:convert';

import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  final SharedPreferences prefs;

  MyHomePage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User _user = User.fromJson(json.decode(prefs.getString('user')));
    // gets logged in user

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80.0,
          ),
          Text(
            'EldersConnect Junior',
            style: MyTextStyles.heading,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Connected to: ${_user.connectedToName}',
            style: MyTextStyles.body,
          ),
        ],
      ),
    );
  }
}
