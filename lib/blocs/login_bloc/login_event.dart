import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AppStarted extends LoginEvent {}

class LoggingInEvent extends LoginEvent {}

class LoggingOutEvent extends LoginEvent {}
