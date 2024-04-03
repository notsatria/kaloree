// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kaloree/theme/color_schemes.g.dart';
import 'package:kaloree/theme/fonts.dart';

class CustomBodySizeForm extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String suffixText;

  const CustomBodySizeForm({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: interRegular.copyWith(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: interRegular.copyWith(
            fontSize: 16,
            color: lightColorScheme.outline,
          ),
          suffixText: suffixText,
          suffixStyle: interRegular.copyWith(
            fontSize: 16,
            color: lightColorScheme.outline,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
