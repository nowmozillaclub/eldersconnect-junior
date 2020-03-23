import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/models/user_repository.dart';
import 'package:ec_junior/services/auth_service.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/first_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserRepository>(create: (_) => UserRepository()),
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<Firestore>(create: (_) => Firestore.instance),
        FutureProvider<SharedPreferences>(
            create: (_) async => SharedPreferences.getInstance()),
      ],
      child: MaterialApp(
        title: 'EldersConnect Junior',
        theme: ThemeData(
          primaryColor: MyColors.primary,
          accentColor: MyColors.accent,
          fontFamily: 'LexendDeca',
          brightness: Brightness.dark,
        ),
        home: FirstPage(),
      ),
    );
  }
}
