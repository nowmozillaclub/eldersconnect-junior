import 'package:ec_junior/utils/colors.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Center(
        child: Hero(
          tag: 'icon',
          child: Container(
            height: 150.0,
            width: 150.0,
            child: Image.asset('assets/icon/icon-legacy.png'),
          ),
        ),
      ),
    );
  }
}
