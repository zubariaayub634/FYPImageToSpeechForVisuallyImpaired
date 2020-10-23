import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:uvea/components/camera.dart';

class CollisionPreventionScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CollisionPreventionScreen({Key key,this.cameras}) : super(key: key);
  @override
  _CollisionPreventionScreenState createState() => _CollisionPreventionScreenState();
}

class _CollisionPreventionScreenState extends State<CollisionPreventionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text("Main Perspective"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Camera(
            widget.cameras,
          ),
        ),
      ),
    );
  }
}
