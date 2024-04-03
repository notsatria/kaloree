import 'package:flutter/material.dart';
import 'package:kaloree/theme/colors.dart';
import 'package:kaloree/utils/platform/app_route.dart';
import 'package:kaloree/widgets/custom_button.dart';

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

BottomAppBar buildCustomBottomAppBar(
    {required String text, required void Function() onTap}) {
  return BottomAppBar(
    color: const Color(0xffEAEAEA),
    elevation: 0,
    child: CustomFilledButton(
      text: text,
      onTap: onTap,
      backgroundColor: onBoardingBackgroundColor,
      textColor: Colors.white,
    ),
  );
}
