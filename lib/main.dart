import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/screens/splashScreen/splashScreen.dart';

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UVEA',
      theme: ThemeData(
          ),
      home: SplashScreen(cameras: cameras),
    );
  }
}
