import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AppStarted extends AuthenticationEvent {}

class LogIn extends AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}
