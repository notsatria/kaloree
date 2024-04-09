// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/theme/color_schemes.g.dart';
import 'package:kaloree/theme/fonts.dart';

class CustomNavigationItem extends StatelessWidget {
  final IconData activeIcon;
  final IconData icon;
  final String label;
  final void Function()? onTap;
  final int index;
  final int currentIndex;
  const CustomNavigationItem({
    Key? key,
    required this.activeIcon,
    required this.icon,
    required this.label,
    this.onTap,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIcon = (currentIndex == index) ? activeIcon : icon;
    final selectedColor = (currentIndex == index)
        ? lightColorScheme.primary
        : lightColorScheme.secondary;

    return Expanded(
      child: InkResponse(
        onTap: onTap,
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
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 58,
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: const Color(0xff6DBB8A),
          shape: BoxShape.circle,
          border: Border.all(
              width: 6, color: const Color(0xffA7F3C0).withOpacity(0.96)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0f000000),
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: const Icon(
          Icons.document_scanner,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}
