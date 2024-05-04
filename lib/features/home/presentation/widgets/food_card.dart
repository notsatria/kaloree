import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/theme/fonts.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'Makanan Berat',
                  style: interMedium.copyWith(fontSize: 16),
                ),
                const Gap(2),
                Text(
                  'Soto Kudus',
                  style: interSemiBold.copyWith(fontSize: 22),
                ),
                const Spacer(),
                const Row(
                  children: [
                    Chip(
                      avatar: Icon(Icons.scale),
                      side: BorderSide.none,
                      color: MaterialStatePropertyAll(Colors.white),
                      label: Text('100 gram'),
                    ),
                    Gap(8),
                    Chip(
                      avatar: Icon(Icons.sports_gymnastics),
                      side: BorderSide.none,
                      color: MaterialStatePropertyAll(Colors.white),
                      label: Text('110Kkal'),
                    ),
                  ],
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
    );
  }
}
