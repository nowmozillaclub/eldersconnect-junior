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
      AuthService _authService = AuthService();
      FirebaseUser _firebaseUser = await _authService.signInWithGoogle();
      SharedPreferences _prefs;

      final String _uuid = Uuid().v4();
      final String _name = _firebaseUser.displayName;
      final String _email = _firebaseUser.email;
      final String _photoUrl = _firebaseUser.photoUrl;

      if (_firebaseUser != null) {
        print('Login success: $_name, $_email');

        User _user = User(
          uuid: _uuid,
          name: _name,
          email: _email,
          photoUrl: _photoUrl,
        );

        _prefs.setBool('isFirstLaunch', false);
        _prefs.setString('user', json.encode(_user));

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
