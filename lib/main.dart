import 'package:flutter/material.dart';

import 'home/home.dart';
import 'injection_container.dart' as injection;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo12',
      theme: ThemeData(
        primaryColor: Color(0xFF4C4C4C),
        accentColor: Color(0xFF4953FF),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontFamily: 'Blinker',
              fontWeight: FontWeight.w800,
              fontSize: 28,
              color: Colors.white),
          headline2: TextStyle(
              fontFamily: 'Blinker',
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.white),
          subtitle1: TextStyle(
              fontFamily: 'Blinker',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white),
          subtitle2: TextStyle(
              fontFamily: 'Blinker',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white),
          bodyText1: TextStyle(
              fontFamily: 'Blinker',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white),
        ),
      ),
      home: HomeView(),
    );
  }
}
