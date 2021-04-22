import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/screens/collisionPreventionScreen/collisionPreventionScreen.dart';
import 'package:uvea/screens/moneyClassifierScreen/moneyClassifierScreen.dart';
import 'package:uvea/components/camera.dart';

class PerspectivesScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  final Camera camera;
  final int firstTime;
  final bool screenReader;

  PerspectivesScreen({Key key, this.cameras, this.firstTime, this.screenReader})
      : camera = Camera(cameras[0]),
        super(key: key);
  final controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    final Widget collisionPreventer = (CollisionPreventionScreen(
      camera: camera,
      firstTime: firstTime,
      screenReader: screenReader,
    ));
    final Widget moneyClassifier = (MoneyClassifierScreen(
      camera: camera,
    ));
    return PageView(
      controller: controller,
      children: <Widget>[
        collisionPreventer,
        moneyClassifier,
      ],
    );
  }
}
