import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:kaloree/core/helpers/image_classification_helper.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/utils/show_snackbar.dart';
import 'package:kaloree/features/scan/presentation/views/scan_result_view.dart';

class CustomCameraScreen extends StatelessWidget {
  const CustomCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.custom(
        builder: (cameraState, preview) {
          return cameraState.when(
            onPreparingCamera: (state) =>
                const Center(child: CircularProgressIndicator()),
            onPhotoMode: (state) => TakePhotoUI(state),
          );
        },
        saveConfig: SaveConfig.photoAndVideo(),
      ),
    );
  }
}

class TakePhotoUI extends StatefulWidget {
  final PhotoCameraState state;

  const TakePhotoUI(this.state, {super.key});

  @override
  State<TakePhotoUI> createState() => _TakePhotoUIState();
}

class _TakePhotoUIState extends State<TakePhotoUI> {
  ImageClassificationHelper? imageClassificationHelper;
  final imagePicker = ImagePicker();
  String? imagePath;
  img.Image? image;
  Map<String, double>? classification;

  @override
  void initState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
    super.initState();
  }

  // Clean old results when press some take picture button
  void cleanResult() {
    imagePath = null;
    image = null;
    classification = null;
    setState(() {});
  }

  // Process picked image
  Future<void> processImage() async {
    if (imagePath != null) {
      // Read image bytes from file
      final imageData = File(imagePath!).readAsBytesSync();

      // Decode image using package:image/image.dart (https://pub.dev/image)
      image = img.decodeImage(imageData);
      setState(() {});
      classification = await imageClassificationHelper?.inferenceImage(image!);
      setState(() {});
    }
  }

  @override
  void dispose() {
    imageClassificationHelper?.close();
    cleanResult();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          right: 40,
          child: MaterialButton(
            minWidth: 58,
            height: 58,
            onPressed: () {
              //
            },
            color: Colors.transparent,
            textColor: Colors.white,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(width: 2, color: Colors.white)),
            child: const Icon(
              Icons.image,
              size: 24,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(bottom: 60.0),
            child: MaterialButton(
              minWidth: 80,
              height: 80,
              onPressed: () {
                widget.state.takePhoto().then((value) {
                  debugPrint('Image path: ${value.path}');

                  imagePath = value.path;
                  setState(() {});
                  processImage();

                  debugPrint("Classification: $classification");

                  if (classification != null) {
                    goTo(
                      context,
                      ScanResultView(
                        imageClassificationHelper: imageClassificationHelper!,
                        image: image!,
                        classification: classification,
                        imagePath: imagePath!,
                      ),
                    );
                    return;
                  }
                  showSnackbar(context, "Klasifikasi Gagal");
                });
              },
              color: Colors.white,
              textColor: Colors.black,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(
                Icons.camera_alt,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
