import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:uvea/components/camera.dart';
import 'package:uvea/components/bodyText.dart';
import 'moneyClassifierModel.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

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

  getOutput(List) async {
    var str = List.toString();
    var str2 = str.split(",");
    var str3 = str2[0].split(" ");
    var confidence = double.parse(str3[1]);
    if (confidence > 0.8) {
      var str4 = str2[2].split(" ");
      await flutterTts.awaitSpeakCompletion(true);
      flutterTts.speak(str4[3] + 'Rupees');
    }
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
    HapticFeedback.vibrate();
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
            HapticFeedback.vibrate();
            flutterTts.setSpeechRate(0.85);
            flutterTts.speak('Swipe right to open collision prevention '
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
