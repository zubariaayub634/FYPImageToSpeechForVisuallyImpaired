import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/screens/onboardingScreen/onboardingScreen.dart';
import 'package:uvea/screens/splashScreen/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CameraDescription> cameras;
var initScreen;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UVEA',
      theme: ThemeData(),
      home: SplashScreen(
        cameras: cameras,
        firstTime: initScreen,
      ),
      //home: SplashScreen(cameras: cameras),
    );
  }
}
