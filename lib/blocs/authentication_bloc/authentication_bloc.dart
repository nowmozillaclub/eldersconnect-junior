import 'dart:convert';

import 'package:ec_junior/blocs/authentication_bloc/authentication_event.dart';
import 'package:ec_junior/blocs/authentication_bloc/authentication_state.dart';
import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/models/user_repository.dart';
import 'package:ec_junior/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
    ) async* {
      if (event is AppStarted) {
        yield* _mapAppStartedToState();
      } else if (event is LoggedIn) {
        yield* _mapLoggedInToState();
      } else if (event is LoggedOut) {
        yield* _mapLoggedOutToState();
      }
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        SharedPreferences prefs;
        final User _user = User.fromJson(json.decode(prefs.getString('user')));
        yield Authenticated(_user);
      } else {
        print('Not logged in');
        yield Unauthenticated();
      }
    } catch (_error) {
      print(_error);
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    SharedPreferences prefs;
    final User _user = User.fromJson(json.decode(prefs.getString('user')));
    yield Authenticated(_user);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    _userRepository.signOut();
    yield Unauthenticated();
  }
}
