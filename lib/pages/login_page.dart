import 'package:ec_junior/models/user_repository.dart';
import 'package:ec_junior/pages/qr_link.dart';
import 'package:ec_junior/services/auth_service.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MyLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = Provider.of<SharedPreferences>(context);
    final _authService = Provider.of<AuthService>(context);

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
                    final _userRepository = UserRepository(prefs);
                    FirebaseUser firebaseUser =
                        await _authService.signInWithGoogle();

                    if (firebaseUser != null) {
                      print('Login success! ${firebaseUser.displayName}');
                      prefs.setBool('isFirstLaunch', false);

                      await _userRepository.updateUser(null, null);

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
