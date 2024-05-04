import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/platform/assets.dart';

class SportCard extends StatelessWidget {
  const SportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffD9F5FF),
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
                  'Penurunan Berat Badan',
                  style: interMedium.copyWith(fontSize: 16),
                ),
                const Gap(2),
                Text(
                  'Bulu Tangkis',
                  style: interSemiBold.copyWith(fontSize: 22),
                ),
                const Spacer(),
                const Row(
                  children: [
                    Chip(
                      avatar: Icon(Icons.access_time),
                      side: BorderSide.none,
                      color: MaterialStatePropertyAll(Colors.white),
                      label: Text('29 Menit'),
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
              badminton,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
