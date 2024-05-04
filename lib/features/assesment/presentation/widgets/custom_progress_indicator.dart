import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double value;
  const CustomProgressIndicator({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: value / 3,
            backgroundColor: lightColorScheme.primaryContainer,
            valueColor:
                AlwaysStoppedAnimation<Color>(lightColorScheme.surfaceTint),
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const Gap(8),
        Text(
          '${value.round()} dari 3',
          style: interMedium.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
