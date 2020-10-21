import 'package:flutter/material.dart';
import 'package:uvea/screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UVEA',
      theme: ThemeData(
        //primaryColor: kPrimaryTextColor,
        //scaffoldBackgroundColor: kScaffoldBackgroundColor,
      ),
      initialRoute: "splashScreen",
      routes: {
        "splashScreen": (context) => SplashScreen(),
      },
    );
  }
}