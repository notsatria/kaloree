import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/features/profile/presentation/widgets/circle_text_icon.dart';
import 'package:kaloree/features/profile/presentation/widgets/profile_list_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: lightColorScheme.outlineVariant,
                radius: 60,
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: lightColorScheme.primary,
                    border: Border.all(width: 4, color: Colors.white),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Satria',
            style: interBold.copyWith(fontSize: 24),
          ),
          Text(
            'halo@email.com',
            style: interMedium.copyWith(color: lightColorScheme.outline),
          ),
          const Gap(20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleTextIcon(title: '4', description: 'Total Porsi'),
              CircleTextIcon(title: '2340 kkal', description: 'Kalori Masuk'),
            ],
          ),
          const Gap(24),
          Container(
            padding: const EdgeInsets.all(margin_16),
            margin: const EdgeInsets.symmetric(horizontal: margin_20),
            decoration: BoxDecoration(
              color: const Color(0xffF0F1ED),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                ProfileListTile(
                  icon: Icons.person_outline,
                  text: 'Edit Profile',
                ),
                ProfileListTile(
                  icon: Icons.settings,
                  text: 'Pengaturan',
                ),
                ProfileListTile(
                  icon: Icons.history,
                  text: 'Riwayat',
                ),
                ProfileListTile(
                  icon: Icons.privacy_tip,
                  text: 'Kebijakan Privasi',
                ),
                ProfileListTile(
                  icon: Icons.help,
                  text: 'Bantuan',
                ),
                ProfileListTile(
                  icon: Icons.logout,
                  text: 'Keluar',
                  type: Type.logout,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
