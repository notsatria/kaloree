import 'package:flutter/material.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';

class EditProfileFormField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const EditProfileFormField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      style: interRegular.copyWith(
        fontSize: 16,
      ),
      validator: validator,
      decoration: InputDecoration(
        errorStyle: interRegular.copyWith(
          fontSize: 12,
          color: lightColorScheme.error,
          height: 0.1,
        ),
        errorBorder: _errorBorder(),
        focusedErrorBorder: _errorBorder(),
        hintText: hintText,
        hintStyle: interRegular.copyWith(
          fontSize: 16,
          color: lightColorScheme.outline,
        ),
        suffixIcon: suffixIcon,
        border: _border(),
        focusedBorder: _border(lightColorScheme.primary),
      ),
    );
  }

  OutlineInputBorder _border([Color? borderColor]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: borderColor ?? lightColorScheme.outline,
      ),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: lightColorScheme.error,
      ),
    );
  }
}
