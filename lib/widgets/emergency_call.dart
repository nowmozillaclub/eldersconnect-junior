import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/text_styles.dart';
import 'package:ec_junior/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

void showEmergencyPopup(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            'Emergency',
            style: isThemeCurrentlyDark(context)
                ? TitleStyles.white
                : TitleStyles.black,
          ),
          content: Text(
            'You can call an Emergency contact',
            style: isThemeCurrentlyDark(context)
                ? BodyStyles.white
                : BodyStyles.black,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              textColor: invertColorsStrong(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text('RTO'),
              color: MyColors.primary,
              textColor: MyColors.accent,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text('SOS'),
              color: MaterialColors.red,
              textColor: MyColors.white,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              onPressed: () {
                Navigator.pop(context);
//                launch('tel:112');
              },
            ),
          ],
        );
      });
}