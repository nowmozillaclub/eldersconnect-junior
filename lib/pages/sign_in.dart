import 'package:ec_junior/pages/home_page.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ec_junior/providers/providers.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  static final String routeName = "/sign-in";

  @override
  Widget build(BuildContext context) {
    UserProvider authenticationProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to',
                  style: TextStyleConfig.title,
                ),
                Text(
                  'EldersConnect Junior',
                  style: TextStyleConfig.heading,
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
                    await authenticationProvider.signInWithGoogle();
                    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
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
