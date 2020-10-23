import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:uvea/screens/collisionPreventionScreen/collisionPreventionScreen.dart';
import 'package:uvea/screens/splashScreen/background.dart';

class SplashScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  SplashScreen({
    Key key,
    this.cameras,
  }) : super(
          key: key,
        );
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "splashScreen",
                ),
                UveaTextButton(
                  "Get Started",
                  onPressed: () {
                    print("button pressed");
                    //TODO: implement onPressed for Get Started button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CollisionPreventionScreen(
                            cameras: widget.cameras,
                          );
                        },
                      ),
                    );
                  },
                ),
                BodyText(
                  "Add your text here! Don't forget to style the text in BodyText class!",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
