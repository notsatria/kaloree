// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/theme/color_schemes.g.dart';
import 'package:kaloree/theme/fonts.dart';

class CustomNavigationItem extends StatelessWidget {
  final bool isActive;
  final IconData activeIcon;
  final IconData icon;
  final String label;
  const CustomNavigationItem({
    Key? key,
    required this.isActive,
    required this.icon,
    required this.label,
    required this.activeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIcon = (isActive) ? activeIcon : icon;
    final selectedColor =
        (isActive) ? lightColorScheme.primary : lightColorScheme.secondary;

    return Expanded(
      child: InkResponse(
        onTap: () {},
        splashFactory: InkRipple.splashFactory,
        radius: 30,
        child: Column(
          children: [
            Icon(
              selectedIcon,
              color: selectedColor,
              size: 28,
            ),
            const Gap(4),
            Text(
              label,
              style: interMedium.copyWith(fontSize: 11, color: selectedColor),
            )
          ],
        ),
      ),
    );
  }
}

class CustomScanNavigationItem extends StatelessWidget {
  const CustomScanNavigationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: const Color(0xff6DBB8A),
        shape: BoxShape.circle,
        border: Border.all(
            width: 6, color: const Color(0xffA7F3C0).withOpacity(0.96)),
      ),
      child: const Icon(
        Icons.document_scanner,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}
