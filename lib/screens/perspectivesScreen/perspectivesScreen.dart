import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uvea/screens/collisionPreventionScreen/collisionPreventionScreen.dart';
import 'package:uvea/screens/moneyCounterScreen/moneyCounterScreen.dart';

class PerspectivesScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  PerspectivesScreen({Key key, this.cameras}) : super(key: key);
  final controller = PageController(initialPage: 0,);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: <Widget>[
        CollisionPreventionScreen(
          cameras: cameras,
        ),
        MoneyCounterScreen(
          cameras: cameras,
        ),
      ],
    );
  }
}
