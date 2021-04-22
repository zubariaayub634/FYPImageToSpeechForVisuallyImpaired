import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:uvea/components/bodyText.dart';
import 'package:uvea/components/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'fdwClassifierModel.dart';
import 'staircaseClassifierModel.dart';

class CollisionPreventionScreen extends StatefulWidget {
  final Camera camera;
  final int firstTime;
  bool spoken = false;

  CollisionPreventionScreen({Key key, this.camera, this.firstTime})
      : super(key: key) {
    //fdwModel.loadModel();
  }

  @override
  _CollisionPreventionScreenState createState() =>
      _CollisionPreventionScreenState();
}

class _CollisionPreventionScreenState extends State<CollisionPreventionScreen> {
  final FDWClassifierModel fdwModel = FDWClassifierModel(
      "assets/fdwModel/model_unquant.tflite", "assets/fdwModel/labels.txt");

  final StaircaseClassifierModel staircaseModel = StaircaseClassifierModel(
      "assets/staircaseModel/staircase_model.tflite",
      "assets/staircaseModel/labels.txt");

  Timer timer;
  //bool title = false;

  void initState() {
    super.initState();

    instructions();
  }

  getOutput(List) async {
    //flutterTts.speak('output');
    var str = List.toString();
    print(str);
    var str2 = str.split(",");
    var str3 = str2[0].split(" ");
    var confidence = double.parse(str3[1]);
    if (confidence > 0.8) {
      var str4 = str2[2].split(" ");
      await flutterTts.awaitSpeakCompletion(true);
      flutterTts.speak(str4[3]);
    }
  }

  instructions() {
    //final FlutterTts flutterTtss = FlutterTts();
    flutterTts.setSpeechRate(0.9);

    if (widget.firstTime == 0 || widget.firstTime == null) {
      if (widget.spoken == true) {
        flutterTts.speak('Collision Prevention');
        Timer(Duration(seconds: 2), () {
          timer = Timer.periodic(
              Duration(seconds: 4), (Timer t) => takePicture(context));
        });
      } else {
        Timer(Duration(seconds: 2), () {
          if (widget.spoken == false) {
            flutterTts.speak('Swipe left to open money classifier... '
                'Long press the screen to repeat the instructions... '
                'Current mode: collision prevention... ');
            widget.spoken = true;
          }
          Timer(Duration(seconds: 2), () {
            timer = Timer.periodic(
                Duration(seconds: 4), (Timer t) => takePicture(context));
          });
        });
      }
    } else {
      flutterTts.speak('collision prevention');
      timer = Timer.periodic(
          Duration(seconds: 3), (Timer t) => takePicture(context));
    }
    //Timer(Duration(seconds: 4), () {});
  }

  takePicture(context) async {
    print("tapped on camera");
    //await Future.delayed(Duration(milliseconds: 200));
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
    //instructions();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Collision Prevention"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: MaterialButton(
          onLongPress: () {
            HapticFeedback.vibrate();
            flutterTts.setSpeechRate(0.85);
            flutterTts.speak('Swipe left to open money classifier'
                '... Long press the screen to repeat the instructions... '
                'Current mode: collision prevention.');
          },
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
