import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/utils/show_snackbar.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/scan/presentation/bloc/image_classification_bloc.dart';
import 'package:kaloree/features/scan/presentation/views/classification_result_view.dart';

class ImageSourceDialog extends StatefulWidget {
  const ImageSourceDialog({super.key});

  @override
  State<ImageSourceDialog> createState() => _ImageSourceDialogState();
}

class _ImageSourceDialogState extends State<ImageSourceDialog> {
  final imagePicker = ImagePicker();
  String? imagePath;
  img.Image? image;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;
  bool _isLoading = false;

  // Clean old results when press some take picture button
  void cleanResult() {
    imagePath = null;
    image = null;
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

      if (image != null) {
        context.read<ImageClassificationBloc>().add(ClassifyImage(image!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageClassificationBloc, ImageClassificationState>(
      listener: (context, state) {
        if (state is ImageClassificationLoading) {
          _isLoading = true;
          setState(() {});
        }

        if (state is ImageClassificationSuccess) {
          final sortedClassifications = (state.classification.entries.toList()
                ..sort((a, b) => a.value.compareTo(b.value)))
              .reversed
              .toList();

          final topClassification = sortedClassifications.take(1).first;

// Find the index of the top classification in the original classification entries list
          final foodId = topClassification.key;
          final originalIndex = state.classification.entries
              .toList()
              .indexWhere((entry) => entry.key == foodId);

          debugPrint('Top Classification Food ID: $foodId');
          debugPrint('Original Index: $originalIndex');

          pop(context);

          goTo(
            context,
            ClassificationResultView(
              sortedClassifications: sortedClassifications,
              imagePath: imagePath!,
              foodId: originalIndex.toString(),
            ),
          );

          setState(() {
            _isLoading = false;
          });
        }

        if (state is ImageClassificationFailure) {
          showSnackbar(context, 'Proses klasifikasi Gagal');
        }
      },
      child: _isLoading ? _showLoadingDialog() : _showSelectImageSourceDialog(),
    );
  }

  AlertDialog _showLoadingDialog() {
    return AlertDialog(
      content: SizedBox(
        height: getMaxWidth(context) / 2,
        width: getMaxWidth(context) / 2,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Loading(),
            Gap(14),
            Text('Sedang menganalisis gambar...'),
          ],
        ),
      ),
    );
  }

  AlertDialog _showSelectImageSourceDialog() {
    return AlertDialog.adaptive(
      title: const Text('Pilih Gambar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galeri'),
            onTap: () async {
              cleanResult();
              final result = await imagePicker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 50,
              );

              imagePath = result?.path;

              setState(() {});
              processImage();
            },
          ),
          if (cameraIsAvailable)
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () async {
                cleanResult();
                final result = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 50,
                );

                imagePath = result?.path;
                setState(() {});
                processImage();
              },
            ),
        ],
      ),
    );
  }
}
