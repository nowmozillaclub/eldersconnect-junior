import 'package:ec_junior/blocs/authentication_bloc/authentication_event.dart';
import 'package:ec_junior/blocs/authentication_bloc/authentication_state.dart';
import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/models/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository _userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LogIn) {
      yield* _mapLoggedInToState();
    } else if (event is LogOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final User _user = _userRepository.getUser();
      if (_user != null) {
        yield Authenticated(_user);
      } else {
        yield Unauthenticated();
      }
    } catch (error) {
      print(error);
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    // TODO: improve
    final User _user = _userRepository.getUser();
    if (_user != null) {
      yield Authenticated(_user);
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    _userRepository.signOut();
    yield Unauthenticated();
  }
}
