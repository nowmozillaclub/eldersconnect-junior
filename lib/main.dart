import 'package:ec_junior/pages/login_page.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EldersConnect Junior',
      theme: ThemeData(
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        fontFamily: 'LexendDeca',
      ),
      home: MyLoginPage(),
    );
  }
}
