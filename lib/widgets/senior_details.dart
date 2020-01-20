import 'package:ec_junior/models/user.dart';
import 'package:flutter/material.dart';

class SeniorDetails extends StatelessWidget {
  @override
  final User seniorUser;

  SeniorDetails({Key key, @required this.seniorUser}) : super(key: key);

  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
                  color: Colors.amber
                ),
              ),
            ),
            Text(
              'Name:',
            ),
            Text(
              'Senior Varun Khatri',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Status:'
            ),
            Text(
              'Healthy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
