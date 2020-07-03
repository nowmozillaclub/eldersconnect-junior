import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/providers/providers.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeniorDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User senior = userProvider.senior;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: ColorConfig.primary,
      ),
      width: (MediaQuery.of(context).size.width * 0.8),
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Senior Details',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(senior.photoUrl),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Text(
                  senior.name,
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Text(
                  'Healthy/Unwell',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
