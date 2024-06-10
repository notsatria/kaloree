// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';

class CustomFoodCalorieForm extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String suffixText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomFoodCalorieForm({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.suffixText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: interRegular.copyWith(
        fontSize: 16,
      ),
      validator: validator,
      decoration: InputDecoration(
        suffixText: suffixText,
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
