import 'package:flutter/material.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/custom_color.g.dart';
import 'package:kaloree/core/theme/fonts.dart';

class AppTheme {
  static lightTheme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        colorScheme: colorScheme,
        extensions: [lightCustomColors],
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: lightColorScheme.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xffEAEAEA),
          elevation: 0,
          iconTheme: IconThemeData(color: lightColorScheme.outline, size: 20),
          centerTitle: true,
          titleTextStyle:
              interMedium.copyWith(fontSize: 14, color: Colors.black),
        ),
      );

  static darkTheme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        colorScheme: colorScheme,
        extensions: [darkCustomColors],
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: darkColorScheme.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xffEAEAEA),
          elevation: 0,
          iconTheme: IconThemeData(color: darkColorScheme.outline, size: 20),
          centerTitle: true,
          titleTextStyle: interMedium.copyWith(
              fontSize: 14, color: darkColorScheme.onPrimary),
        ),
      );
}
