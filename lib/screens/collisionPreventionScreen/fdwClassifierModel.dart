import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

class FDWClassifierModel {
  final String modelPath;
  final String labelPath;
  bool modelLoaded=false;

  FDWClassifierModel(this.modelPath, this.labelPath);

  loadModel() async {
    String res;
    res = await Tflite.loadModel(
      model: this.modelPath,
      labels: this.labelPath,
    );
    print(res);
    modelLoaded=true;
    print("model loaded");
  }

  Future<String> predict(CameraImage img) async{
    int startTime = new DateTime.now().millisecondsSinceEpoch;
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

      return recognitions.toString();

      //widget.setRecognitions(recognitions, img.height, img.width);

      //isDetecting = false;
    });
    return ("Error Encountered");
  }
}
