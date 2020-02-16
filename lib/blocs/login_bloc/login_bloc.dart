import 'package:ec_junior/blocs/auth_bloc/auth_state.dart';
import 'package:ec_junior/blocs/login_bloc/login_event.dart';
import 'package:ec_junior/blocs/login_bloc/login_state.dart';
import 'package:ec_junior/services/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthState authState;
  final UserRepository userRepository;
  LoginBloc({@required this.authState, @required this.userRepository})
      : assert(authState != null),
        assert(userRepository != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) {
    return null;
  }
}
