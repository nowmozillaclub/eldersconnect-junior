import 'package:ec_junior/blocs/login_bloc/bloc.dart';
import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/models/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AppStarted) {
      {
        final User _user = _userRepository.getUser();
        if (_user != null) {
          yield LoggedInState(_user);
        } else {
          yield LoggedOutState();
        }
      }
    } else if (event is LoggingInEvent) {
      {
        final User _user = await _userRepository.signInWithGoogle();
        if (_user != null) {
          yield LoggedInState(_user);
        } else {
          yield LoggedOutState();
        }
      }
    } else if (event is LoggingOutEvent) {
      {
        _userRepository.signOut();
        yield LoggedOutState();
      }
    }
  }
}
