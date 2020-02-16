import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  final String _displayName;

  const Authenticated(this._displayName);

  String get displayName => _displayName;

  @override
  String toString() {
    return 'Authenticated {_displayName: $_displayName}';
  }
}

class UnAuthenticated extends AuthState {}
