// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:kaloree/core/helpers/image_classification_helper.dart';

class ScanResultView extends StatelessWidget {
  final ImageClassificationHelper imageClassificationHelper;
  final img.Image image;
  final Map<String, double>? classification;
  final String imagePath;

  const ScanResultView({
    Key? key,
    required this.imageClassificationHelper,
    required this.image,
    required this.classification,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Image.file(File(imagePath)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(),
            ...[
              // Show model information
              Text(
                'Input: (shape: ${imageClassificationHelper.inputTensor.shape} type: '
                '${imageClassificationHelper.inputTensor.type})',
              ),
              Text(
                'Output: (shape: ${imageClassificationHelper.outputTensor.shape} '
                'type: ${imageClassificationHelper.outputTensor.type})',
              ),
              const SizedBox(height: 8),
              // Show picked image information
              Text('Num channels: ${image.numChannels}'),
              Text('Bits per channel: ${image.bitsPerChannel}'),
              Text('Height: ${image.height}'),
              Text('Width: ${image.width}'),
            ],
            const Spacer(),
            // Show classification result
            SingleChildScrollView(
              child: Column(
                children: [
                  if (classification != null)
                    ...(classification!.entries.toList()
                          ..sort(
                            (a, b) => a.value.compareTo(b.value),
                          ))
                        .reversed
                        .take(3)
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Text(e.key),
                                const Spacer(),
                                Text(e.value.toStringAsFixed(2))
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
