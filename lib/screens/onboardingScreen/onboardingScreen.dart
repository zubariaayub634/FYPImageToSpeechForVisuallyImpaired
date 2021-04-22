import 'package:flutter/material.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:uvea/screens/perspectivesScreen/perspectivesScreen.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

class OnboardingScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  final int firstTime;
  final bool screenReader;

  OnboardingScreen({Key key, this.cameras, this.firstTime, this.screenReader})
      : super(
          key: key,
        );

  callScreen(context) {
    if (screenReader == false) {
      Timer(
        Duration(seconds: 9),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PerspectivesScreen(
                cameras: cameras,
                firstTime: firstTime,
                screenReader: screenReader,
              );
            },
          ),
        ),
      );
    }
  }

  UveaTextButton showButton(context) {
    if (screenReader == false) {}
  }

  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    //showButton(context);
    if (screenReader == false) {
      flutterTts.setSpeechRate(0.7);
      flutterTts.speak('Uvea is a mobile application... '
          'for day-to-day aid of...'
          'visually impaired... '
          'helping you detect macro objects &'
          'count money');
      callScreen(context);
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
              BodyText("A mobile application for day-to-day aid of"
                  " visually impaired helping you detect macro objects & "
                  "count money"),
              Padding(padding: EdgeInsets.only(top: 50)),
            ],
          ),
        ),
      );
    } else {
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
                semanticLabel: 'Chair and Cupboard',
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              BodyText("A mobile application for day-to-day aid of"
                  " visually impaired helping you detect macro objects & "
                  "count money"),
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
                          screenReader: screenReader,
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
