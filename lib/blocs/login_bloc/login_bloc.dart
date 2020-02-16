import 'package:ec_junior/blocs/login_bloc/login_event.dart';
import 'package:ec_junior/blocs/login_bloc/login_state.dart';
import 'package:ec_junior/services/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;
  LoginBloc({@required this.authenticationBloc, @required this.userRepository})
      : assert(authenticationBloc != null),
        assert(userRepository != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) {
    return null;
  }
}
