import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/pages/home_page.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyQRLinkPage extends StatelessWidget {
  final SharedPreferences prefs;

  MyQRLinkPage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User _user = User.fromJson(json.decode(prefs.getString('user')));
    final Firestore _instance = Firestore.instance;

    Future<void> _writeToDb(String _seniorUid) async {
      await _instance.collection('users').document('${_user.uid}').setData({
        'uid': _user.uid,
        'name': _user.name,
        'email': _user.email,
        'photoUrl': _user.photoUrl,
        'connectedToUid': _seniorUid,
        'connectedToName': _seniorUid,
      });
    }

    Future<String> _scanQrCode() async {
      String qrCode;
      try {
        qrCode = await BarcodeScanner.scan();
      } on PlatformException catch (_error) {
        if (_error.code == BarcodeScanner.CameraAccessDenied) {
          print('Camera permission denied');
        } else {
          print('Error: $_error');
        }
      }
      return qrCode;
    }

    return Scaffold(
      backgroundColor: MyColors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome, ${_user.name}',
                style: MyTextStyles.title,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Scan the code shown in EldersConnect Senior',
                style: MyTextStyles.body,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text('Scan Code'),
                color: MyColors.primary,
                onPressed: () async {
                  String seniorUid = await _scanQrCode();
                  if (seniorUid != null) {
                    await _writeToDb(seniorUid);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(prefs: this.prefs)),
                        (Route<dynamic> route) => false);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
