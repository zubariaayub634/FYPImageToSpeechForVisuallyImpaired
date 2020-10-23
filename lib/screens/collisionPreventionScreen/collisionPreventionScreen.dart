import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:uvea/components/camera.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uvea/components/uveaTextButton.dart';

class CollisionPreventionScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CollisionPreventionScreen({Key key, this.cameras}) : super(key: key);
  @override
  _CollisionPreventionScreenState createState() =>
      _CollisionPreventionScreenState();
}

class _CollisionPreventionScreenState extends State<CollisionPreventionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Collision Prevention"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: MaterialButton(
          onPressed: () {
            print("tapped on camera");
            Alert(
                style: AlertStyle(
                  backgroundColor: Colors.blueGrey,
                ),
                context: context,
                title:
                    "You tapped on the camera. This is a dummy. You will see popup collision prevention messages in the next version of the product.",
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    UveaTextButton(
                      "OK",
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    color: Colors.white,
                    height: 0,
                  ),
                ]).show();
          },
          child: Camera(
            widget.cameras,
          ),
        ),
      ),
    );
  }
}
