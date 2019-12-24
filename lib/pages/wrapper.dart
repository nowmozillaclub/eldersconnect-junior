import 'package:ec_junior/pages/home.dart';
import 'package:ec_junior/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firebaseUser = Provider.of<FirebaseUser>(context);
    return _firebaseUser == null ? Register() : Home();
  }
}
