import 'package:ec_junior/pages/pages.dart';
import 'package:ec_junior/pages/time_picker.dart';
import 'package:ec_junior/utils/utils.dart' show ColorConfig;
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
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProxyProvider<UserProvider, TimeTableProvider>(
          create: (_) => TimeTableProvider(null, null, null, null),
          update: (context, value, previous) =>
              TimeTableProvider(value.user, value.senior, value.setupUser, value.updateTimetableId),
        ),
      ],
      child: MaterialApp(
        title: 'EldersConnect Junior',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ColorConfig.primary,
          accentColor: ColorConfig.accent,
          fontFamily: 'LexendDeca',
          brightness: Brightness.dark,
        ),
        initialRoute: SplashPage.routeName,
        routes: {
          SignInPage.routeName: (context) => SignInPage(),
          HomePage.routeName: (context) => HomePage(),
          TimePicker.routeName: (context) => TimePicker(),
        },
        home: SplashPage(),
      ),
    );
  }
}
