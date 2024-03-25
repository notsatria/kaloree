import 'package:flutter/material.dart';
import 'package:kaloree/theme/color_schemes.g.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:kaloree/widgets/loading.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final void Function() onTap;
  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(rounded_8),
        ),
        child: Center(
          child: (isLoading)
              ? const CircularProgressIndicator.adaptive()
              : Text(
                  text,
                  style: interSemiBold.copyWith(
                    fontSize: 16,
                    color: lightColorScheme.primary,
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
  const CustomOutlinedButton({
    super.key,
    this.leadingIcon,
    required this.text,
    this.isLoading = false,
    required this.onTap,
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
            color: Colors.white,
            width: 3,
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
                          color: Colors.white,
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
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
