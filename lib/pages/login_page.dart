import 'dart:convert';

import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/pages/home_page.dart';
import 'package:ec_junior/services/auth_service.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class MyLoginPage extends StatelessWidget {
  final SharedPreferences prefs;
  AuthService _authService = AuthService();

  MyLoginPage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to',
                  style: MyTextStyles.subtitle,
                ),
                Text(
                  'EldersConnect Junior',
                  style: MyTextStyles.title,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Hero(
                  tag: 'icon',
                  child: Container(
                    height: 125.0,
                    width: 125.0,
                    child: Image.asset('assets/icon/icon-legacy.png'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GoogleSignInButton(
                  onPressed: () async {
                    BlocProvider.of<LoginBloc>(context).add(
                      LoginButtonPressed(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
