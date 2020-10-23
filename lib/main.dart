import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/screens/splashScreen/splashScreen.dart';
import 'package:uvea/screens/mainPerspectiveScreen/mainPerspectiveScreen.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
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
        "splashScreen": (context) => SplashScreen(cameras: cameras),
        "mainPerspectiveScreen": (context) => MainPerspectiveScreen(),
      },
    );
  }
}
