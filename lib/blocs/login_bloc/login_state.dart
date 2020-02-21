import 'package:ec_junior/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class InitialState extends LoginState {}

class LoggedInState extends LoginState {
  final User _user;
  LoggedInState(this._user);

  @override
  List<Object> get props => [_user];
}

class LoggedOutState extends LoginState {}
