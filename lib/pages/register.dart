import 'package:ec_junior/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(child: Text('Please Log in')),
              FlatButton(
                child: Text('Sign In With Google'),
                onPressed: () async {
                  FirebaseUser _firebaseUser = await _authService.signInWithGoogle();
                  if (_firebaseUser != null) {
                    print(_firebaseUser.email);
                  } else {
                    print('Not logged in');
                  }
                },
              )
            ],
          ),
        )
      ),
    );
  }
}

