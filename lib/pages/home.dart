import 'package:ec_junior/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ec_junior/services/auth.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firebaseUser = Provider.of<FirebaseUser>(context);

    AuthService _authService = AuthService();
    FirebaseDatabase _firebaseDatabase = FirebaseDatabase(uid: _firebaseUser.uid, emailId: _firebaseUser.email);
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
                  ),
                  FlatButton(
                    child: Text('Scan QR Code'),
                    onPressed: () async {
                      try {
                        String barcode = await BarcodeScanner.scan();
                        _firebaseDatabase.connectToSeniorApp(barcode);
                      } catch(error) {
                        print(error);
                      }
                    },
                  )
                ],
              )
          )
      ),
    );
  }
}

