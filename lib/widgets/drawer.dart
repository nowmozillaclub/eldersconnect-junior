import 'package:ec_junior/pages/home_page.dart';
import 'package:ec_junior/pages/time_picker.dart';
import 'package:ec_junior/pages/timetableviewer.dart';
import 'package:ec_junior/providers/providers.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildDrawerMenu(String title, Icon icon, Function tapHandler) =>
      ListTile(
        onTap: tapHandler,
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'icon',
              child: Container(
                height: 200.0,
                width: 200.0,
                child: Image.asset('assets/icon/icon-legacy.png'),
              ),
            ),
            Text('EldersConnect Junior'),
            SizedBox(
              height: 20.0,
            ),
            _buildDrawerMenu(
              'Home',
              Icon(
                Icons.home,
              ),
                  () {
                    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
                  },
            ),
            _buildDrawerMenu(
              'View Timetable',
              Icon(
                Icons.calendar_today,
              ),
              () {
                Navigator.of(context).pushNamed(TimeTableView.routeName);
              },
            ),

            _buildDrawerMenu(
              'Option 3',
              Icon(
                Icons.phone_android,
              ),
              () {},
            ),
          ],
        ),
      ),
    );
  }
}
