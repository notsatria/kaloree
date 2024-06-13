import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image/image.dart' as img;
import 'package:kaloree/core/helpers/image_classification_helper.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/theme/colors.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/scan/presentation/widgets/custom_food_calorie_form.dart';
import 'package:kaloree/features/scan/presentation/widgets/custom_food_name_result_form.dart';

class ClassificationResultView extends StatefulWidget {
  final ImageClassificationHelper imageClassificationHelper;
  final img.Image image;
  final Map<String, double>? classification;
  final String? imagePath;
  const ClassificationResultView({
    super.key,
    required this.imagePath,
    required this.imageClassificationHelper,
    required this.image,
    this.classification,
  });

  @override
  State<ClassificationResultView> createState() =>
      _ClassificationResultViewState();
}

class _ClassificationResultViewState extends State<ClassificationResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: 'Tambah Log Kalori', context: context),
      bottomNavigationBar:
          buildCustomBottomAppBar(text: 'Simpan', onTap: () {}),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        child: SizedBox(
          width: getMaxWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: widget.imagePath != null
                    ? Image.file(
                        File(widget.imagePath!),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey[300],
                        child: Center(
                          child: Image.asset(
                            iconPizza,
                            width: 100,
                          ),
                        ),
                      ),
              ),
              const Gap(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildResultCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
      decoration: BoxDecoration(
        boxShadow: customBoxShadow,
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama makanan',
            style: interMedium.copyWith(fontSize: 14),
          ),
          const Gap(8),
          const CustomFoodNameResultForm(hintText: 'Nama Makanan'),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Jumlah Kalori (kkal)',
                  style: interMedium.copyWith(fontSize: 14),
                ),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  'Berat (gram)',
                  style: interMedium.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: CustomFoodCalorieForm(
                  hintText: 'Jumlah Kalori',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  suffixText: 'kkal',
                  controller: TextEditingController(),
                ),
              ),
              const Gap(8),
              Expanded(
                child: CustomFoodCalorieForm(
                  hintText: 'Berat',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  suffixText: 'gram',
                  controller: TextEditingController(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
