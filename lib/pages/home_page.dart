import 'package:ec_junior/models/models.dart';
import 'package:ec_junior/pages/pages.dart';
import 'package:ec_junior/providers/user_provider.dart';
import 'package:ec_junior/widgets/drawer.dart';
import 'package:ec_junior/widgets/photo_circle_avatar.dart';
import 'package:ec_junior/widgets/senior_detail.dart';
import 'package:ec_junior/widgets/senior_logs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PopUpMenuOptions {
  Setting,
  Reconnect,
  LogOut,
}

class HomePage extends StatelessWidget {
  static final String routeName = "/home";

  Future<void> _handleOptionSelection(
      BuildContext context, dynamic selectedOption) async {
    if (selectedOption == PopUpMenuOptions.Setting) {
      print('settings');
    } else if (selectedOption == PopUpMenuOptions.Reconnect) {
      print('reconnect');
    } else if (selectedOption == PopUpMenuOptions.LogOut) {
      await Provider.of<UserProvider>(context, listen: false).signOut();
      Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> seniorLogs = {
      'Today': {
        '8:00AM': 'Took Medicines',
        '9:00AM': 'Walked for 35 minutes',
        '10:00AM': 'Had breakfast',
        '12:00PM': 'Had Lunch'
      },
      'Yesterday': {
        '8:00AM': 'Took Medicines',
        '9:00AM': 'Walked for 35 minutes',
        '10:00AM': 'Had breakfast',
        '12:00PM': 'Had Lunch'
      },
      'tomorrow': {
        '8:00AM': 'Took Medicines',
        '9:00AM': 'Walked for 35 minutes',
        '10:00AM': 'Had breakfast',
        '12:00PM': 'Had Lunch'
      },
      'tomorow': {
        '8:00AM': 'Took Medicines',
        '9:00AM': 'Walked for 35 minutes',
        '10:00AM': 'Had breakfast',
        '12:00PM': 'Had Lunch'
      },
    };

    UserProvider authenticationProvider = Provider.of<UserProvider>(context);
    User _mainUser = authenticationProvider.user;
    print(_mainUser.timetableId);

    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('EldersConnect Junior'),
          actions: [
            PopupMenuButton(
              onSelected: (dynamic optionSelected) async {
                await _handleOptionSelection(context, optionSelected);
              },
              child: PhotoCircleAvatarWidget(
                isUnknown: false,
                photoUrl: _mainUser.photoUrl,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Logged In As',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    _mainUser.photoUrl,
                                  ),
                                ),
                              ),
                              Text(
                                _mainUser.name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  enabled: false,
                ),
                PopupMenuItem(
                  child: Text('Settings'),
                  value: PopUpMenuOptions.Setting,
                ),
                PopupMenuItem(
                  child: Text('Reconnect To Senior'),
                  value: PopUpMenuOptions.Reconnect,
                ),
                PopupMenuItem(
                  child: Text('Log Out'),
                  value: PopUpMenuOptions.LogOut,
                ),
              ],
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: authenticationProvider.senior != null
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SeniorDetailsWidget(),
                    SeniorLogsWidget(),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'No senior connection detected. Please connect to EldersConnect Senior app first.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
