import 'package:flutter/material.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  const CustomFormField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        style: interRegular.copyWith(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: interRegular.copyWith(
            fontSize: 16,
            color: lightColorScheme.outline,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: lightColorScheme.outline,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
