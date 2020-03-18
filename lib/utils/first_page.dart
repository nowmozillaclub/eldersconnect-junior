import 'package:ec_junior/models/user_repository.dart';
import 'package:ec_junior/pages/login_page.dart';
import 'package:ec_junior/pages/qr_link.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void firstPageChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _userRepository = UserRepository(prefs);
    final _user = _userRepository.getUser();

    Future.delayed(Duration(seconds: 1), () {
      // splash screen kinda thing
      if (_user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyLoginPage(prefs: prefs)),
            (Route<dynamic> route) => false);
        // very first launch since install
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyQRLinkPage(prefs: prefs)),
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
      color: MyColors.black,
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
