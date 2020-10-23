import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:uvea/screens/perspectivesScreen/perspectivesScreen.dart';
import 'package:uvea/screens/splashScreen/background.dart';

import '../../components/bodyText.dart';
import 'background.dart';

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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 120)),
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
                Padding(padding: EdgeInsets.only(top: 20)),
                BodyText("A mobile application for day-to-day aid of"),
                BodyText("visually impaired."),
                Padding(padding: EdgeInsets.only(top: 50)),
                BodyText(
                  "We recommend taking help from a visually-abled ",
                  size: 15,
                ),
                BodyText(
                  "friend or family member to help set up.",
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
