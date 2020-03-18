import 'package:ec_junior/models/user_repository.dart';
import 'package:ec_junior/pages/qr_link.dart';
import 'package:ec_junior/services/auth_service.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MyLoginPage extends StatelessWidget {
  final SharedPreferences prefs;
  AuthService _authService = AuthService();

  MyLoginPage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: MyColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                              builder: (context) =>
                                  MyQRLinkPage(prefs: this.prefs)),
                          (Route<dynamic> route) => false);
                    } else {
                      print('Error logging in');
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Error logging in'),
                        ),
                      );
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
