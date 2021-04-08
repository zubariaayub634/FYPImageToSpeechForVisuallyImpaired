import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/camera.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'fdwClassifierModel.dart';

class CollisionPreventionScreen extends StatefulWidget {
  final Camera camera;

  CollisionPreventionScreen({Key key, this.camera}) : super(key: key) {
    //fdwModel.loadModel();
  }

  @override
  _CollisionPreventionScreenState createState() =>
      _CollisionPreventionScreenState();
}

class _CollisionPreventionScreenState extends State<CollisionPreventionScreen> {
  final FDWClassifierModel fdwModel = FDWClassifierModel(
      "assets/fdwModel/model_unquant.tflite", "assets/fdwModel/labels.txt");

  Timer timer;
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => takePicture(context));
  }

  /*callTimer(context) {
    Timer(Duration(milliseconds: 3000), () {
      //after 3 seconds this will be called,
      //once this is called take picture or whatever function you need to do
      takePicture(context);
    });
  }*/

  getOutput(List) {
    var str = List.toString();
    var str2 = str.split(",");
    var str3 = str2[2].split(" ");
    flutterTts.speak(str3[3]);
  }

  takePicture(context) async {
    print("tapped on camera");
    await widget.camera.controller.startImageStream(
      (CameraImage img) async {
        widget.camera.controller.stopImageStream();
        print("camera stream going on");
        try {
          int startTime = new DateTime.now().millisecondsSinceEpoch;
          //await Tflite.close();
          await fdwModel.loadModel();
          await Tflite.runModelOnFrame(
            bytesList: img.planes.map(
              (plane) {
                return plane.bytes;
              },
            ).toList(),
            imageHeight: img.height,
            imageWidth: img.width,
            numResults: 2,
          ).then((recognitions) {
            int endTime = new DateTime.now().millisecondsSinceEpoch;
            print("Detection took ${endTime - startTime}");
            print(recognitions.runtimeType);
            print(recognitions);
            getOutput(recognitions.toList()[0]);

            //return recognitions.toString();
            /*Alert(
                style: AlertStyle(
                  backgroundColor:
                      Color(0x5F90A4AE), //Colors.blueGrey//Color(0x551761a0),
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
                ),
                /*: Text(
                              "Model is loading, please try again.",
                              style: TextStyle(color: Colors.white),
                            )*/
                buttons: [
                  DialogButton(
                    color: Colors.white,
                    height: 0,
                  ),
                ]).show();*/
          });
        } on PlatformException catch (e) {
          print(e.message);
        }
      },
    );
  }

  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    flutterTts.speak('Collision Prevention');

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Collision Prevention"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          child: widget.camera,
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
