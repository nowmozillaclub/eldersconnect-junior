import 'package:ec_junior/blocs/login_bloc/bloc.dart';
import 'package:ec_junior/pages/home_page.dart';
import 'package:ec_junior/pages/login_page.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (context) => LoginBloc()..add(AppStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EldersConnect Junior',
      theme: ThemeData(
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        fontFamily: 'LexendDeca',
        brightness: Brightness.light,
      ),
      home: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoggedOutState)
            return MyLoginPage();
          else if (state is LoggedInState)
            return MyHomePage();
          else
            return MySplashScreen();
        },
      ),
    );
  }
}
