import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';

class CatatanItemCard extends StatelessWidget {
  final ClassificationResult classificationResult;
  const CatatanItemCard({
    super.key,
    required this.classificationResult,
  });

  @override
  Widget build(BuildContext context) {
    final weight = convertWeight(classificationResult.food.weight);
    final calories = convertCalories(classificationResult.food.calories);
    final carbs = convertWeight(classificationResult.food.carbohydrate);
    final protein = convertWeight(classificationResult.food.protein);
    final fat = convertWeight(classificationResult.food.fat);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(classificationResult.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    classificationResult.food.name,
                    style: interSemiBold.copyWith(
                      color: const Color(0xff5D5F5C),
                      fontSize: 16,
                    ),
                  ),
                  const Gap(8),
                  SizedBox(
                    height: 40, // Set height to limit the ListView
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Chip(
                          avatar: const Icon(
                            Icons.scale,
                            size: 14,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            weight,
                            style: interRegular.copyWith(fontSize: 12),
                          ),
                        ),
                        const Gap(4),
                        Chip(
                          avatar: Image.asset(
                            iconCalorie,
                            width: 24,
                            color: lightColorScheme.outline,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            calories,
                            style: interRegular.copyWith(fontSize: 12),
                          ),
                        ),
                        const Gap(4),
                        Chip(
                          avatar: Image.asset(
                            iconCarbs,
                            width: 24,
                            color: lightColorScheme.outline,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            carbs,
                            style: interRegular.copyWith(fontSize: 12),
                          ),
                        ),
                        const Gap(4),
                        Chip(
                          avatar: Image.asset(
                            iconFat,
                            width: 24,
                            color: lightColorScheme.outline,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            fat,
                            style: interRegular.copyWith(fontSize: 12),
                          ),
                        ),
                        const Gap(4),
                        Chip(
                          avatar: Image.asset(
                            iconProtein,
                            width: 24,
                            color: lightColorScheme.outline,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            protein,
                            style: interRegular.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String convertWeight(double weight) {
    if (weight >= 1000) {
      weight = weight / 1000;
      return '${weight.toStringAsFixed(1)} kg';
    } else {
      return '${weight.toStringAsFixed(1)} gr';
    }
  }

  String convertCalories(double calories) {
    if (calories >= 1000) {
      calories = calories / 1000;
      return '${calories.toStringAsFixed(1)} kkal';
    } else {
      return '${calories.toStringAsFixed(1)} kal';
    }
  }
}
