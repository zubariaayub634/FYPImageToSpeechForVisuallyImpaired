import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:uvea/components/camera.dart';

class MoneyCounterScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  MoneyCounterScreen({Key key, this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Money Counter"),
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
                    "You tapped on the camera. This is a dummy. You will see popup money counting messages in the next version of the product.",
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
            cameras,
          ),
        ),
      ),
    );
  }
}
