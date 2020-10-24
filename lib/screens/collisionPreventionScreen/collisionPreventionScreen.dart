import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/camera.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uvea/components/uveaTextButton.dart';

class CollisionPreventionScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  CollisionPreventionScreen({Key key, this.cameras}) : super(key: key);

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
                  backgroundColor:
                      Color(0x5F90A4AE), //Colors.blueGrey//Color(0x551761a0),
                  titleStyle: TextStyle(color: Colors.white),
                  overlayColor: Color(0xCF000000),
                ), //Colors.black54),
                context: context,
                title:
                    "You tapped on the camera. This is a dummy. You will see popup collision prevention messages in the next version of the product.",
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    UveaTextButton(
                      "OK",
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 8,
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
            cameras,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: BodyText(
          'Swipe left to switch to Money Counter',
        ),
        elevation: 0,
      ),
    );
  }
}
