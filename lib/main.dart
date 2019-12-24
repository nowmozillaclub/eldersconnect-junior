import 'package:ec_junior/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ec_junior/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().firebaseUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EldersConnect Junior',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
