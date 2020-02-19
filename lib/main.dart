import 'package:ec_junior/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ec_junior/blocs/authentication_bloc/authentication_event.dart';
import 'package:ec_junior/blocs/authentication_bloc/authentication_state.dart';
import 'package:ec_junior/pages/home_page.dart';
import 'package:ec_junior/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserRepository _userRepository;
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated)
            return MyLoginPage();
          else if (state is Authenticated)
            return MyHomePage();
          else
            return MyLoginPage();
        },
      ),
    );
  }
}
