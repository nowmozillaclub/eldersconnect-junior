import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class SignInButtonPressed extends LoginEvent {}
