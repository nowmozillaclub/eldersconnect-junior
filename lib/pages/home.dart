import 'package:flutter/material.dart';
import 'package:ec_junior/services/auth.dart';
import 'package:barcode_scan/barcode_scan.dart';

class Home extends StatelessWidget {
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print(barcode);
    } catch(error) {
      print(error);
    }
  }

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
                  ),
                  FlatButton(
                    child: Text('Scan QR Code'),
                    onPressed: scan,
                  )
                ],
              )
          )
      ),
    );
  }
}

