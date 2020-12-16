import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/screens/collisionPreventionScreen/collisionPreventionScreen.dart';
import 'package:uvea/screens/moneyCounterScreen/moneyCounterScreen.dart';

class PerspectivesScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  final Widget collisionPreventer;
  final Widget moneyCounter;

  PerspectivesScreen({Key key, this.cameras})
      : collisionPreventer = (CollisionPreventionScreen(
          cameras: cameras,
        )),
        moneyCounter = (MoneyCounterScreen(
          cameras: cameras,
        )),
        super(key: key);
  final controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: <Widget>[
        collisionPreventer,
        moneyCounter,
      ],
    );
  }
}
