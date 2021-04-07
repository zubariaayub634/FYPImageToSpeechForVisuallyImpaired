import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tflite/tflite.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:uvea/components/camera.dart';
import 'package:uvea/components/bodyText.dart';
import 'moneyClassifierModel.dart';
import 'dart:async';

class MoneyClassifierScreen extends StatefulWidget {
  final Camera camera;

  MoneyClassifierScreen({Key key, this.camera}) : super(key: key) {
    //moneyModel.loadModel();
  }

  @override
  _MoneyClassifierScreenState createState() => _MoneyClassifierScreenState();
}

class _MoneyClassifierScreenState extends State<MoneyClassifierScreen> {
  final MoneyClassifierModel moneyModel = MoneyClassifierModel(
      "assets/moneyModel/model_unquant.tflite", "assets/moneyModel/labels.txt");

  Timer timer;
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => takePicture(context));
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
          await moneyModel.loadModel();
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
            //return recognitions.toString();
            Alert(
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
                ]).show();
          });
        } on PlatformException catch (e) {
          print(e.message);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Money Classifier"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(child: Container(child: widget.camera)),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: BodyText(
          'Swipe right to switch to Collision Prevention',
        ),
        elevation: 0,
      ),
    );
  }
}
