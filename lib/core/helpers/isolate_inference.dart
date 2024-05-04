import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;

class IsolateInference {
  static const String _debugName = 'TFLITE_INFERENCE';
  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: _debugName,
    );
    _sendPort = await _receivePort.first;
  }

  Future<void> close() async {
    _receivePort.close();
    _isolate.kill();
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final InferenceModel isolateModel in port) {
      image_lib.Image? img;
      if (isolateModel.isCameraFrame()) {
        img = ImageUtils.convertCameraImage(isolateModel.cameraImage!);
      } else {
        img = isolateModel.image;
      }
    }
  }

}
  class InferenceModel {
    CameraImage? cameraImage;
    image_lib.Image? image;
    int interpreterAddress;
    List<String> labels;
    List<int> inputShape;
    List<int> outputShape;
    late SendPort responsePort;

    InferenceModel(
       this.cameraImage,
       this.image,
       this.interpreterAddress,
       this.labels,
       this.inputShape,
       this.outputShape,
    );

    bool isCameraFrame() {
      return cameraImage != null;
    }

  }
