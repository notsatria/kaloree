import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_error_view.dart';
import 'package:kaloree/features/profile/presentation/bloc/get_user_data_on_profile_bloc.dart';
import 'package:kaloree/features/profile/presentation/widgets/profile_list_tile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<GetUserDataOnProfileBloc>().add(GetUserDataOnProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataOnProfileBloc, GetUserDataOnProfileState>(
      builder: (context, state) {
        log('State in Profile View: $state');
        if (state is GetUserDataOnProfileSuccess) {
          final user = state.user;
          return _buildProfileViewSuccess(user);
        } else if (state is GetUserDataOnProfileFailure) {
          return Scaffold(
            body: ErrorView(message: state.message),
          );
        } else {
          return const Scaffold(
            body: Loading(),
          );
        }
      },
    );
  }

  AppBar _buildCatatanAppBar() {
    return AppBar(
      backgroundColor: lightColorScheme.background,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text('Profil Pengguna'),
    );
  }

  Scaffold _buildProfileViewSuccess(UserModel user) {
    return Scaffold(
      appBar: _buildCatatanAppBar(),
      body: Column(
        children: [
          const Gap(12),
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: lightColorScheme.outlineVariant,
                radius: 60,
                child:
                    Image.network('${user.profilePicture}', fit: BoxFit.cover),
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
          const Gap(20),
          Text(
            '${user.fullName}',
            style: interBold.copyWith(fontSize: 24),
          ),
          Text(
            user.email,
            style: interMedium.copyWith(color: lightColorScheme.outline),
          ),
          const Gap(24),
          Container(
            padding: const EdgeInsets.all(margin_16),
            margin: const EdgeInsets.symmetric(horizontal: margin_20),
            decoration: BoxDecoration(
              color: const Color(0xffF0F1ED),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const ProfileListTile(
                  icon: Icons.person_outline,
                  text: 'Edit Profile',
                ),
                const ProfileListTile(
                  icon: Icons.settings,
                  text: 'Pengaturan',
                ),
                const ProfileListTile(
                  icon: Icons.privacy_tip,
                  text: 'Kebijakan Privasi',
                ),
                const ProfileListTile(
                  icon: Icons.help,
                  text: 'Bantuan',
                ),
                ProfileListTile(
                  icon: Icons.logout,
                  text: 'Keluar',
                  type: Type.logout,
                  onTap: () {
                    showLogoutConfirmationDialog(context, () {
                      _logout(context);
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void showLogoutConfirmationDialog(
      BuildContext context, void Function()? onYesPressed) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari aplikasi?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: onYesPressed,
              child: const Text('Yakin'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      goReplacementNamed(context, AppRoute.login);
    });
  }
}
