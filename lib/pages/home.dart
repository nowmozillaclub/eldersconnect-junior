import 'package:flutter/material.dart';
import 'package:ec_junior/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    return Container(
      child: Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hello World'),
                  FlatButton(
                    child: Text('Sign Out'),
                    onPressed: () async {
                      _authService.signOut();
                    },
                  )
                ],
              )
          )
      ),
    );
  }
}

