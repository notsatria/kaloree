import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';

class CustomFoodNameResultForm extends StatelessWidget {
  final String hintText;

  const CustomFoodNameResultForm({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      style: interRegular.copyWith(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          FontAwesomeIcons.bowlFood,
          size: 24,
        ),
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
