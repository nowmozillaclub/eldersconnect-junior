import 'package:ec_junior/pages/login_page.dart';
import 'package:ec_junior/pages/qr_link.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void firstPageChecker() async {
    final prefs = Provider.of<SharedPreferences>(context);
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    Future.delayed(Duration(seconds: 1), () {
      // splash screen kinda thing
      if (isFirstLaunch) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyLoginPage()),
            (Route<dynamic> route) => false);
        // very first launch since install
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyQRLinkPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    firstPageChecker();
  }

  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Center(
        child: Hero(
          tag: 'icon',
          child: Container(
            height: 200.0,
            width: 200.0,
            child: Image.asset('assets/icon/icon-legacy.png'),
          ),
        ),
      ),
    );
  }
}
