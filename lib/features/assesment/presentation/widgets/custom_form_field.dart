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
  final TextEditingController? controller;
  final void Function()? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  const CustomFormField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        validator: validator,
        style: interRegular.copyWith(
          fontSize: 16,
        ),
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
          prefixIcon: Icon(
            prefixIcon,
            color: lightColorScheme.outline,
          ),
          suffixIcon: suffixIcon,
          border: _border(),
          focusedBorder: _border(lightColorScheme.primary),
        ),
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
