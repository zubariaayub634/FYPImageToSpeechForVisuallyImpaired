import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:uvea/components/camera.dart';

class MainPerspectiveScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  MainPerspectiveScreen({Key key,this.cameras}) : super(key: key);
  @override
  _MainPerspectiveScreenState createState() => _MainPerspectiveScreenState();
}

class _MainPerspectiveScreenState extends State<MainPerspectiveScreen> {
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
