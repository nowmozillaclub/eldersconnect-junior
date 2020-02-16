import 'package:ec_junior/blocs/auth_bloc/auth_event.dart';
import 'package:ec_junior/blocs/auth_bloc/auth_state.dart';
import 'package:ec_junior/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if(event is A)
  }
}
