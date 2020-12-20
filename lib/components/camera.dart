import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:math' as math;

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final CameraController controller;

  Camera(this.cameras)
      : controller = CameraController(
          cameras[0],
          ResolutionPreset.high, //change to ResolutionPreset.low if frame drop rate is too high
        ) {
    if (cameras == null || cameras.length < 1) {
      print('No camera is found');
    } else {
      controller.initialize().then((_) {
        /*if (!mounted) {
          return;
        }*/
       // setState(() {});
      });
    }
  }

  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller == null || !widget.controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = widget.controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(widget.controller),
    );
  }
}
