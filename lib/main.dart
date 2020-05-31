import 'package:ec_junior/pages/sign_in.dart';
import 'package:ec_junior/utils/colors.dart';
import 'package:ec_junior/utils/first_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ec_junior/providers/providers.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'EldersConnect Junior',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MyColors.primary,
          accentColor: MyColors.accent,
          fontFamily: 'LexendDeca',
          brightness: Brightness.dark,
        ),
        routes: {
          SignInPage.routeName: (context) => SignInPage(),
        },
        home: SignInPage(),
      ),
    );
  }
}
