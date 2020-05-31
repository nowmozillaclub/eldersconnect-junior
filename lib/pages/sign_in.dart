import 'package:flutter/material.dart';
import 'package:ec_junior/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:ec_junior/models/models.dart';

class SignInPage extends StatelessWidget {
  static final String routeName = "/sign-in";

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authentication = Provider.of<AuthenticationProvider>(
      context,
      listen: true,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Log In'),
              onPressed: () {
                authentication.signInWithGoogle();
              },
            ),
            RaisedButton(
              child: Text('Log Out'),
              onPressed: () {
                authentication.signOut();
              },
            ),
            FutureBuilder<User>(
              future: authentication.user,
              builder: (context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.name);
                } else {
                  return Text('Please Log In');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
