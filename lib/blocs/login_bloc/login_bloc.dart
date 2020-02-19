import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ec_junior/models/user_repository.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) await _userRepository.signInWithGoogle();
  }
}
