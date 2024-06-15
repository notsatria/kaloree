import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image/image.dart' as img;
import 'package:kaloree/core/model/food.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/colors.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/utils/show_snackbar.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/scan/presentation/bloc/image_classification_bloc.dart';
import 'package:kaloree/features/scan/presentation/widgets/custom_food_name_result_form.dart';
import 'package:kaloree/features/scan/presentation/widgets/custom_food_weight_form.dart';

class ClassificationResultView extends StatefulWidget {
  final String foodId;
  final img.Image image;
  final String? imagePath;
  const ClassificationResultView({
    super.key,
    required this.imagePath,
    required this.image,
    required this.foodId,
  });

  @override
  State<ClassificationResultView> createState() =>
      _ClassificationResultViewState();
}

class _ClassificationResultViewState extends State<ClassificationResultView> {
  final weightController = TextEditingController(text: '100');
  double weight = 100;

  @override
  void initState() {
    super.initState();
    context
        .read<ImageClassificationBloc>()
        .add(GetFoodDetailEvent(widget.foodId));
  }

  @override
  void dispose() {
    super.dispose();
    weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageClassificationBloc, ImageClassificationState>(
      listener: (context, state) {
        if (state is GetFoodDetailFailure) {
          debugPrint("Error: ${state.error}");
          showSnackbar(context, state.error);
        }
      },
      child: Scaffold(
        appBar: buildCustomAppBar(title: 'Tambah Log Kalori', context: context),
        bottomNavigationBar: buildCustomBottomAppBar(
            text: 'Simpan',
            onTap: () {
              //
            }),
        body: BlocBuilder<ImageClassificationBloc, ImageClassificationState>(
          builder: (context, state) {
            if (state is GetFoodDetailSuccess) {
              final food = state.food;
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: kBottomNavigationBarHeight,
                  bottom: MediaQuery.of(context).padding.top,
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
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _buildResultCard(food),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is GetFoodDetailFailure) {
              return SizedBox(
                width: getMaxWidth(context),
                height: getMaxHeight(context),
                child: Center(
                  child: Text(state.error),
                ),
              );
            } else if (state is GetFoodDetailLoading) {
              return const Loading();
            } else {
              return SizedBox(
                width: getMaxWidth(context),
                height: getMaxHeight(context),
                child: const Center(
                  child: Text('Terjadi Kesalahan'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Container _buildResultCard(Food food) {
    double foodCalories = food.calories / 100 * weight;
    double foodCarbs = food.carbohydrate / 100 * weight;
    double foodFat = food.fat / 100 * weight;
    double foodProtein = food.calories / 100 * weight;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
          CustomFoodNameResultForm(
            hintText: 'Nama Makanan',
            initialValue: food.name,
          ),
          const Gap(8),
          Text(
            'Berat (gram)',
            style: interMedium.copyWith(fontSize: 14),
          ),
          const Gap(8),
          CustomFoodWeightForm(
            hintText: 'Berat',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            suffixText: 'gram',
            controller: weightController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
            ],
            onChanged: (value) {
              setState(() {
                if (value == "") {
                  value = "0";
                }
                weight = double.parse(value!);
              });
            },
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Kalori',
                  style: interMedium.copyWith(fontSize: 14),
                ),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  'Karbohidrat',
                  style: interMedium.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildCustomCard(
                    iconPath: iconCalorie,
                    text: '${foodCalories.toStringAsFixed(2)}kal'),
              ),
              const Gap(8),
              Expanded(
                child: _buildCustomCard(
                    iconPath: iconCarbs,
                    text: '${foodCarbs.toStringAsFixed(2)}gr'),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Protein',
                  style: interMedium.copyWith(fontSize: 14),
                ),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  'Lemak',
                  style: interMedium.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildCustomCard(
                    iconPath: iconProtein,
                    text: '${foodProtein.toStringAsFixed(2)}gr'),
              ),
              const Gap(8),
              Expanded(
                child: _buildCustomCard(
                    iconPath: iconFat, text: '${foodFat.toStringAsFixed(2)}gr'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card _buildCustomCard({required String iconPath, required String text}) {
    return Card(
      color: lightColorScheme.background,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 70,
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 24,
              color: lightColorScheme.outline,
            ),
            const Gap(4),
            Text(
              text,
              style: interSemiBold.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
