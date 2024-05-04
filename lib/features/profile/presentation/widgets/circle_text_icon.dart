// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:kaloree/core/theme/fonts.dart';

class CircleTextIcon extends StatelessWidget {
  final String title;
  final String description;
  const CircleTextIcon({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xffd9d9d9),
          radius: 25,
          child: FaIcon(
            FontAwesomeIcons.spoon,
            color: Color(0xff767874),
          ),
        ),
        const Gap(2),
        Text(
          title,
          style: interBold,
        ),
        Text(
description,
          style: interMedium.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
