import 'package:ec_junior/blocs/authentication_bloc/authentication_event.dart';
import 'package:ec_junior/blocs/authentication_bloc/authentication_state.dart';
import 'package:ec_junior/models/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final SharedPreferences _prefs;

  AuthenticationBloc({UserRepository userRepository, SharedPreferences prefs})
      : assert(userRepository != null),
        assert(prefs != null),
        _userRepository = userRepository,
        _prefs = prefs;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      try {
        bool isFirstLaunch = _prefs.getBool('isFirstLaunch') ?? true;
        bool isUserLoggedIn = _prefs.getString('user') ?? true;
        if (await _userRepository.isSignedIn() && isUserLoggedIn) {
          yield Authenticated();
        } else if (isFirstLaunch) {
          yield Loading();
        } else {
          yield Unauthenticated();
        }
      } catch (error) {
        yield Unauthenticated();
      }
    } else if (event is LoggedIn) {
      yield Authenticated();
    } else if (event is LoggedOut) {
      yield Unauthenticated();
    }
  }
}
