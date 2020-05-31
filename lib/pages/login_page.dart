import 'package:ec_junior/models/user_repository.dart';
import 'package:ec_junior/pages/qr_link.dart';
import 'package:ec_junior/services/auth_service.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to',
                  style: MyTextStyles.title,
                ),
                Text(
                  'EldersConnect Junior',
                  style: MyTextStyles.heading,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Hero(
                  tag: 'icon',
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset('assets/icon/icon-legacy.png'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GoogleSignInButton(
                  darkMode: true,
                  onPressed: () async {
                    final _prefs = await SharedPreferences.getInstance();
                    final _userRepo =
                        Provider.of<UserRepository>(context, listen: false);
                    final _authService =
                        Provider.of<AuthService>(context, listen: false);
                    final _firebaseUser = await _authService.signInWithGoogle();

                    if (_firebaseUser != null) {
                      print('Login success! ${_firebaseUser.displayName}');
                      _prefs.setBool('isFirstLaunch', false);

                      await _userRepo.updateUser(null, null);

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyQRLinkPage()),
                          (Route<dynamic> route) => false);
                    } else {
                      print('Error logging in');
                    }
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
