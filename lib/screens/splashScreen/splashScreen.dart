import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:uvea/screens/perspectivesScreen/perspectivesScreen.dart';
import 'package:uvea/screens/splashScreen/background.dart';

class SplashScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  SplashScreen({
    Key key,
    this.cameras,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
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
                          return PerspectivesScreen(
                            cameras: cameras,
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
