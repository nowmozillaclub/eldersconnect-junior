import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => null;
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final FirebaseUser _firebaseUser;
  LoginSuccess(FirebaseUser firebaseUser) : _firebaseUser = firebaseUser;

  FirebaseUser get firebaseUser => _firebaseUser;
}

class LoginFailed extends LoginState {
  final String _error;

  LoginFailed(this._error);

  @override
  String toString() {
    return 'Error: ${this._error}';
  }
}
