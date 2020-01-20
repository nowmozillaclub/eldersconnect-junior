import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:flutter/material.dart';

class SeniorDetails extends StatelessWidget {
  @override
  final User seniorUser;

  SeniorDetails({Key key, @required this.seniorUser}) : super(key: key);

  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: MyColors.primary,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Senior details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
                ),
              ),
            ),

            Text(
              'Name:',
              style: TextStyle(
                  color: Colors.white70),
            ),
            Text(
              'Senior Varun Khatri',
              style: TextStyle(color: Colors.white)),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Status:',
                style: TextStyle(
                color: Colors.white70),
            ),
            Text(
              'Healthy',
              style: TextStyle(color: Colors.lightGreenAccent,),
            ),
            Text(
              'Dying',
              style: TextStyle(color: Colors.redAccent,),
            )
          ],
        ),
      ),
    );
  }
}
