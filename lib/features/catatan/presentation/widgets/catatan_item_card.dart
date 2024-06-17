import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/core/theme/fonts.dart';

class CatatanItemCard extends StatelessWidget {
  final ClassificationResult classificationResult;
  const CatatanItemCard({
    super.key,
    required this.classificationResult,
  });

  @override
  Widget build(BuildContext context) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classificationResult.food.name,
                  style: interSemiBold.copyWith(
                    color: const Color(0xff5D5F5C),
                    fontSize: 16,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                      avatar: const Icon(
                        Icons.scale,
                        size: 14,
                      ),
                      side: BorderSide.none,
                      color: const MaterialStatePropertyAll(Colors.white),
                      label: Text(
                        '${classificationResult.food.weight} gram',
                        style: interRegular.copyWith(fontSize: 12),
                      ),
                    ),
                    const Gap(4),
                    Chip(
                      avatar: const Icon(
                        Icons.sports_gymnastics,
                        size: 14,
                      ),
                      side: BorderSide.none,
                      color: const MaterialStatePropertyAll(Colors.white),
                      label: Text(
                        '${classificationResult.food.calories}kal',
                        style: interRegular.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
