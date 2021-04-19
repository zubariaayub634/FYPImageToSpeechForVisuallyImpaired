import 'package:flutter/material.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:uvea/screens/perspectivesScreen/perspectivesScreen.dart';
import 'file:///C:/Users/mesha/Desktop/Semester%208/FYP%202/Uvea/lib/screens/onboardingScreen/background.dart';
import 'package:camera/camera.dart';

class onboardingScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  final int firstTime;

  onboardingScreen({Key key, this.cameras, this.firstTime})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/onboardingLogo.png',
              height: 400,
              width: 400, // * 0.35,
              //fit: BoxFit.contain,
              //scale: 0.9,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            BodyText("A mobile application for day-to-day aid of"),
            BodyText("visually impaired."),
            Padding(padding: EdgeInsets.only(top: 50)),
            UveaTextButton(
              "Get Started",
              onPressed: () {
                print("button pressed");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PerspectivesScreen(
                        cameras: cameras,
                        firstTime: firstTime,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
