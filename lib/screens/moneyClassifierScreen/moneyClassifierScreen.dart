import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uvea/components/uveaTextButton.dart';
import 'package:uvea/components/camera.dart';
import 'package:uvea/components/bodyText.dart';
import 'moneyClassifierModel.dart';

class MoneyClassifierScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  final Camera camera;
  final MoneyClassifierModel moneyModel = MoneyClassifierModel(
      "assets/moneyModel/model_unquant.tflite", "assets/moneyModel/labels.txt");

  MoneyClassifierScreen({Key key, this.cameras})
      : camera = Camera(cameras),
        super(key: key) {
    moneyModel.loadModel();
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
      body: SafeArea(
        child: MaterialButton(
          onPressed: () {
            print("tapped on camera");
            camera.controller.startImageStream((CameraImage img) {
              /*if (!isDetecting) {
                isDetecting = true;

                int startTime = new DateTime.now().millisecondsSinceEpoch;

                if (widget.model == mobilenet) {
                  Tflite.runModelOnFrame(
                    bytesList: img.planes.map((plane) {
                      return plane.bytes;
                    }).toList(),
                    imageHeight: img.height,
                    imageWidth: img.width,
                    numResults: 2,
                  ).then((recognitions) {
                    int endTime = new DateTime.now().millisecondsSinceEpoch;
                    print("Detection took ${endTime - startTime}");

                    widget.setRecognitions(recognitions, img.height, img.width);

                    isDetecting = false;
                  });
                } else if (widget.model == posenet) {
                  Tflite.runPoseNetOnFrame(
                    bytesList: img.planes.map((plane) {
                      return plane.bytes;
                    }).toList(),
                    imageHeight: img.height,
                    imageWidth: img.width,
                    numResults: 2,
                  ).then((recognitions) {
                    int endTime = new DateTime.now().millisecondsSinceEpoch;
                    print("Detection took ${endTime - startTime}");

                    widget.setRecognitions(recognitions, img.height, img.width);

                    isDetecting = false;
                  });
                } else {
                  Tflite.detectObjectOnFrame(
                    bytesList: img.planes.map((plane) {
                      return plane.bytes;
                    }).toList(),
                    model: widget.model == yolo ? "YOLO" : "SSDMobileNet",
                    imageHeight: img.height,
                    imageWidth: img.width,
                    imageMean: widget.model == yolo ? 0 : 127.5,
                    imageStd: widget.model == yolo ? 255.0 : 127.5,
                    numResultsPerClass: 1,
                    threshold: widget.model == yolo ? 0.2 : 0.4,
                  ).then((recognitions) {
                    int endTime = new DateTime.now().millisecondsSinceEpoch;
                    print("Detection took ${endTime - startTime}");

                    widget.setRecognitions(recognitions, img.height, img.width);

                    isDetecting = false;
                  });
                }
              }*/
              //print("image stream started");
            });
            Alert(
                style: AlertStyle(
                  backgroundColor:
                      Color(0x5F90A4AE), //Colors.blueGrey//Color(0x551761a0),
                  overlayColor: Color(0xCF000000),
                ),
                context: context,
                title: "",
                content: moneyModel.modelLoaded
                    ? Column(
                        children: <Widget>[
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "You tapped on the camera. This is a dummy. You will see popup money classifying messages in the next version of the product.",
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
                    : Text(
                        "Model is loading, please try again.",
                        style: TextStyle(color: Colors.white),
                      ),
                buttons: [
                  DialogButton(
                    color: Colors.white,
                    height: 0,
                  ),
                ]).show();
          },
          child: camera,
        ),
      ),
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
