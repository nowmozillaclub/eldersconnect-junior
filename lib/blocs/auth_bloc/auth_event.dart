import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoggedIn extends AuthEvent {
  final FirebaseUser firebaseUser;
  LoggedIn({@required this.firebaseUser});

  FirebaseUser get user => firebaseUser;
}

class LoggedOut extends AuthEvent {}
