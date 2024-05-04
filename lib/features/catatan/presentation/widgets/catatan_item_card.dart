import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/theme/fonts.dart';

class CatatanItemCard extends StatelessWidget {
  const CatatanItemCard({
    super.key,
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(soto),
                ),
              ),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soto Kudus',
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
                        '100 gram',
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
                        '110Kkal',
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
