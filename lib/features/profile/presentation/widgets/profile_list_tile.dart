// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Type type;
  const ProfileListTile({
    Key? key,
    required this.icon,
    required this.text,
    this.type = Type.regular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case Type.regular:
        return _buildRegularTile();
      case Type.logout:
        return _buildLogoutTile();
    }
  }

  Widget _buildRegularTile() => Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: lightColorScheme.outline,
            ),
            const Gap(20),
            Text(
              text,
              style: interSemiBold,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Color(0xff767874),
            ),
          ],
        ),
      );

  Widget _buildLogoutTile() => Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: lightColorScheme.error,
            ),
            const Gap(20),
            Text(
              text,
              style: interSemiBold.copyWith(color: lightColorScheme.error),
            ),
          ],
        ),
      );
}

enum Type {
  regular,
  logout,
}
