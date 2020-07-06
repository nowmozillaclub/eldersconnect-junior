import 'package:ec_junior/pages/home_page.dart';
import 'package:ec_junior/pages/pages.dart';
import 'package:ec_junior/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  static final String routeName = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .setupUser()
        .catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('An Error Occurred'),
          content: Text(
              'An error occurred when signing you in. Please try signing in again.'),
          actions: [
            FlatButton(
              child: Text('OKAY'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInPage.routeName);
              },
            )
          ],
        ),
      );
    }).then((value) {
      if (value == null) {
        Navigator.of(context)
            .pushReplacementNamed(SignInPage.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: 'icon',
              child: Container(
                height: 200.0,
                width: 200.0,
                child: Image.asset('assets/icon/icon-legacy.png'),
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
