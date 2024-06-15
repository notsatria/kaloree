import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';

class ErrorView extends StatelessWidget {
  final String message;
  const ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgError,
            width: getMaxWidth(context) / 1.4,
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              style: interSemiBold.copyWith(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
