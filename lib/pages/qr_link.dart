import 'package:barcode_scan/barcode_scan.dart';
import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/models/user_repository.dart';
import 'package:ec_junior/pages/home_page.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyQRLinkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = Provider.of<SharedPreferences>(context);
    final _instance = Provider.of<Firestore>(context);
    final _userRepository = UserRepository(prefs);
    final User _user = _userRepository.getUser();

    Future<String> _scanQrCode() async {
      String qrCode;
      try {
        qrCode = await BarcodeScanner.scan();
      } on PlatformException catch (error) {
        if (error.code == BarcodeScanner.CameraAccessDenied) {
          print('Camera permission denied');
        } else {
          print('Error: $error');
        }
      }
      return qrCode;
    }

    return Scaffold(
      body: Container(
        color: MyColors.black,
        child: Row(
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
                      prefs.setBool('isConnected', true);
                      await _userRepository.updateUser(seniorUid, null);
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
      ),
    );
  }
}
