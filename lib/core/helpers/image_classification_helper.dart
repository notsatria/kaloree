import 'package:tflite_flutter/tflite_flutter.dart';

class ImageClassificationHelper {
  static const modelPath = 'assets/models/cancer_classification.tflite';
  static const labelsPath = 'assets/models/labels.txt';

  late final Interpreter interpreter;
  late final List<String> labels;
  late final IsolateInference isolateInference;
}
