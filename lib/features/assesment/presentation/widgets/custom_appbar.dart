import 'package:flutter/material.dart';
import 'package:kaloree/utils/platform/app_route.dart';

AppBar buildCustomAppBar(
    {required String title, required BuildContext context}) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios),
    ),
    title: Text(title),
  );
}
