import 'package:ec_junior/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Loading extends AuthenticationState {}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User _user;
  Authenticated(this._user);

  @override
  List<Object> get props => [_user];
}

class Unauthenticated extends AuthenticationState {}
