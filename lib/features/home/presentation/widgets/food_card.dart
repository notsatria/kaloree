import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/theme/fonts.dart';

class FoodCard extends StatelessWidget {
  final void Function()? onTap;
  const FoodCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffFFDAD6),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rekomendasi Makanan',
                    style: interMedium.copyWith(fontSize: 16),
                  ),
                  const Gap(2),
                  Text(
                    'Gemini AI',
                    style: interSemiBold.copyWith(fontSize: 22),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        const Center(child: Text('Personalisasi Makanan Anda')),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset(
                soto,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
