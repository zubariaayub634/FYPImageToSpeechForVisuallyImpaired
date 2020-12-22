import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/camera.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uvea/components/uveaTextButton.dart';

import 'fdwClassifierModel.dart';

class CollisionPreventionScreen extends StatelessWidget {
  final Camera camera;
  final FDWClassifierModel fdwModel = FDWClassifierModel(
      "assets/fdwModel/model.tflite", "assets/fdwModel/labels.txt");

  CollisionPreventionScreen({Key key, this.camera}) : super(key: key) {
    //fdwModel.loadModel();
  }

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
          onPressed: () async {
            print("tapped on camera");
            await camera.controller.startImageStream((CameraImage img) async {
              camera.controller.stopImageStream();
              print("camera stream going on");
              try {
                int startTime = new DateTime.now().millisecondsSinceEpoch;
                //await Tflite.close();
                await fdwModel.loadModel();
                await Tflite.runModelOnFrame(
                  bytesList: img.planes.map((plane) {
                    return plane.bytes;
                  }).toList(),
                  imageHeight: img.height,
                  imageWidth: img.width,
                  numResults: 2,
                ).then((recognitions) {
                  int endTime = new DateTime.now().millisecondsSinceEpoch;
                  print("Detection took ${endTime - startTime}");
                  print(recognitions.runtimeType);
                  print(recognitions);

                  //return recognitions.toString();

                  Alert(
                      style: AlertStyle(
                        backgroundColor: Color(
                            0x5F90A4AE), //Colors.blueGrey//Color(0x551761a0),
                        overlayColor: Color(0xCF000000),
                      ),
                      context: context,
                      title: "",
                      content: //fdwModel.modelLoaded ?
                      Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  recognitions.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
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
                                  height: 8,
                                ),
                              ],
                            )
                          /*: Text(
                              "Model is loading, please try again.",
                              style: TextStyle(color: Colors.white),
                            )*/,
                      buttons: [
                        DialogButton(
                          color: Colors.white,
                          height: 0,
                        ),
                      ]).show();
                });
              } on PlatformException catch (e) {
                print(e.message);
              }
            });
          },
          child: camera,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: BodyText(
          'Swipe left to switch to Money Classifier',
        ),
        elevation: 0,
      ),
    );
  }
}
