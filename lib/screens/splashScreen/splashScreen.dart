import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/screens/onboardingScreen/onboardingScreen.dart';
import 'package:uvea/screens/perspectivesScreen/perspectivesScreen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final firstTime;

  SplashScreen({Key key, this.cameras, this.firstTime}) : super(key: key);
  @override
  _SplashScreen createState() => _SplashScreen();
}

void callScreen(context, firstTime, camera) {
  if (firstTime == 0 || firstTime == null) {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(
            cameras: camera,
            firstTime: firstTime,
            screenReader: screenReaderOn(context),
          ),
        ),
      ),
    );
  } else {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PerspectivesScreen(
            cameras: camera,
            firstTime: firstTime,
            screenReader: screenReaderOn(context),
          ),
        ),
      ),
    );
  }
}

bool screenReaderOn(context) {
  final mediaQueryData = MediaQuery.of(context);
  if (mediaQueryData.accessibleNavigation) {
    return true;
  } else {
    return false;
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    callScreen(context, widget.firstTime, widget.cameras);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      child: Positioned(
        top: 130,
        left: 0,
        child: Image.asset(
          "assets/uveaLogo.png",
          height: 180,
          width: size.width, // * 0.35,
        ),
      ),
    );
  }
}

/*class SplashScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  SplashScreen({
    Key key,
    this.cameras,
  }) : super(
          key: key,
        );

  @override
  void callCamera() {}
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 130)),
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
}*/
