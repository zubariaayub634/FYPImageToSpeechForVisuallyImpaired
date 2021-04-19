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
import 'package:flutter_tts/flutter_tts.dart';

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
        Timer.periodic(Duration(seconds: 3), (Timer t) => takePicture(context));
  }

  getOutput(List) {
    var str = List.toString();
    var str2 = str.split(",");
    var str3 = str2[2].split(" ");
    flutterTts.speak(str3[3] + 'Rupees');
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
            getOutput(recognitions.toList()[0]);
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
    flutterTts.speak('Money Classifier');
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
          onLongPress: () {
            flutterTts.setSpeechRate(0.85);
            flutterTts.speak('Swipe right to open collision prevention... '
                '... Long press the screen to repeat the instructions... '
                'Current mode: money classifier.');
          },
          child: widget.camera,
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
