import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, {Color? backgroundColor}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message),
      ),
    );
}
