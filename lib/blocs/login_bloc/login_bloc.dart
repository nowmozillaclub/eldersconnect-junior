import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ec_junior/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ec_junior/blocs/authentication_bloc/bloc.dart';
import 'package:ec_junior/blocs/login_bloc/login_event.dart';
import 'package:ec_junior/blocs/login_bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc})
      : assert(authenticationBloc != null);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) authenticationBloc.add(LogIn());
  }
}
