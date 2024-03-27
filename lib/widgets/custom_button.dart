import 'package:flutter/material.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:kaloree/widgets/loading.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final void Function() onTap;
  final Color backgroundColor;
  final Color textColor;
  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(rounded_8),
        ),
        child: Center(
          child: (isLoading)
              ? const CircularProgressIndicator.adaptive()
              : Text(
                  text,
                  style: interSemiBold.copyWith(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool isLoading;
  final Widget? leadingIcon;
  final Color outlineColor;
  final Color textColor;
  final double outlineWidth;
  const CustomOutlinedButton({
    super.key,
    this.leadingIcon,
    required this.text,
    this.isLoading = false,
    required this.onTap,
    required this.outlineColor,
    required this.textColor,
    required this.outlineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rounded_8),
          border: Border.all(
            color: outlineColor,
            width: outlineWidth,
          ),
        ),
        child: (isLoading)
            ? const Loading()
            : Center(
                child: (leadingIcon == null)
                    ? Text(
                        text,
                        style: interSemiBold.copyWith(
                          fontSize: 16,
                          color: textColor,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          leadingIcon!,
                          const SizedBox(width: 8),
                          Text(
                            text,
                            style: interSemiBold.copyWith(
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
