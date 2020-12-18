import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/screens/collisionPreventionScreen/collisionPreventionScreen.dart';
import 'package:uvea/screens/moneyClassifierScreen/moneyClassifierScreen.dart';

class PerspectivesScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  final Widget collisionPreventer;
  final Widget moneyClassifier;

  PerspectivesScreen({Key key, this.cameras})
      : collisionPreventer = (CollisionPreventionScreen(
          cameras: cameras,
        )),
        moneyClassifier = (MoneyClassifierScreen(
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
        moneyClassifier,
      ],
    );
  }
}
