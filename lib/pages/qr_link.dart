//import 'package:barcode_scan/barcode_scan.dart';
//import 'package:ec_junior/models/user_repository.dart';
//import 'package:ec_junior/pages/home_page.dart';
//import 'package:ec_junior/utils/colors.dart';
//import 'package:ec_junior/utils/text_styles.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class MyQRLinkPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    Future<String> _scanQrCode() async {
//      String qrCode;
//      try {
//        qrCode = await BarcodeScanner.scan();
//      } on PlatformException catch (error) {
//        if (error.code == BarcodeScanner.CameraAccessDenied) {
//          print('Camera permission denied');
//        } else {
//          print('Error: $error');
//        }
//      }
//      return qrCode;
//    }
//
//    return Scaffold(
//      body: Container(
//        color: ColorConfig.black,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(
//                  'Welcome!',
//                  style: TextStyleConfig.title,
//                ),
//                SizedBox(
//                  height: 20.0,
//                ),
//                Text(
//                  'Scan the code from EldersConnect Senior',
//                  style: TextStyleConfig.body,
//                ),
//                SizedBox(
//                  height: 20.0,
//                ),
//                RaisedButton(
//                  child: Text('Scan Code'),
//                  color: ColorConfig.primary,
//                  onPressed: () async {
//                    final _prefs = await SharedPreferences.getInstance();
//                    final _userRepo =
//                        Provider.of<UserRepository>(context, listen: false);
//                    final seniorUid = await _scanQrCode();
//
//                    if (seniorUid != null) {
//                      _prefs.setBool('isConnected', true);
//                      await _userRepo.updateUser(seniorUid, null);
//                      Navigator.pushAndRemoveUntil(
//                          context,
//                          MaterialPageRoute(builder: (context) => HomePage()),
//                          (Route<dynamic> route) => false);
//                    }
//                  },
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
