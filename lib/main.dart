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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
