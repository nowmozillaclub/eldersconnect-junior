import 'package:ec_junior/pages/time_picker.dart';
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
              'Set Timetable',
              Icon(
                Icons.timer,
              ),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimePicker()),
                );
              },
            ),
            _buildDrawerMenu(
              'Option 2',
              Icon(
                Icons.phone_android,
              ),
              () {},
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
