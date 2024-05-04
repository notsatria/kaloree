// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';

class CustomGenderChip extends StatelessWidget {
  final GenderType genderType;
  final bool isSelected;
  final void Function(bool)? onSelected;
  const CustomGenderChip({
    Key? key,
    required this.genderType,
    required this.isSelected,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color selectedColor =
        (isSelected) ? lightColorScheme.primary : lightColorScheme.outline;

    return ChoiceChip(
      selected: isSelected,
      showCheckmark: false,
      onSelected: onSelected,
      padding: EdgeInsets.all(getMaxWidth(context) * 0.16),
      pressElevation: 4,
      selectedColor: lightColorScheme.primaryContainer,
      label: Column(
        children: [
          Icon(
            (genderType == GenderType.male) ? Icons.male : Icons.female,
            color: selectedColor,
            size: 60,
          ),
          const Gap(8),
          Text(
            (genderType == GenderType.male) ? 'Pria' : 'Wanita',
            style: interRegular.copyWith(
              fontSize: 16,
              color: selectedColor,
            ),
          ),
        ],
      ),
      shape: const CircleBorder(),
      side: BorderSide(color: selectedColor, width: 2),
    );
  }
}

enum GenderType {
  male,
  female,
}
