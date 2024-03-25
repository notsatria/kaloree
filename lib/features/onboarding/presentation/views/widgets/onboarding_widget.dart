import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/theme/fonts.dart';

class OnBoardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const OnBoardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: interBold.copyWith(fontSize: 28, color: Colors.white),
            ),
            const Gap(14),
            Text(
              description,
              textAlign: TextAlign.center,
              style: interMedium.copyWith(fontSize: 12, color: Colors.white),
            ),
            const Gap(8),
            Image.asset(image),
          ],
        ),
      ),
    );
  }
}
