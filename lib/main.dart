import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/first_page.dart';
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
        brightness: Brightness.dark,
      ),
      home: FirstPage(),
    );
  }
}
