import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'icon',
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  child: Image.asset('assets/icon/icon-legacy.png'),
                ),
              ),
              Text(
                'EldersConnect',
                style: MyTextStyles.title,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
