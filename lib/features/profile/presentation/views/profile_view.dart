import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_error_view.dart';
import 'package:kaloree/features/profile/presentation/bloc/get_user_data_on_profile_bloc.dart';
import 'package:kaloree/features/profile/presentation/views/edit_profile_view.dart';
import 'package:kaloree/features/profile/presentation/views/sport_recommendation_list_view.dart';
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
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              '${user.profilePicture}',
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),
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
                ProfileListTile(
                  icon: Icons.person_outline,
                  text: 'Edit Profile',
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileView(user: user),
                      ),
                    );

                    if (result == true) {
                      context
                          .read<GetUserDataOnProfileBloc>()
                          .add(GetUserDataOnProfile());
                    }
                  },
                ),
                ProfileListTile(
                  icon: Icons.book,
                  text: 'Hasil Asesmen',
                  onTap: () {
                    goToNamed(context, AppRoute.assesmentResult);
                  },
                ),
                ProfileListTile(
                  icon: Icons.sports_gymnastics,
                  text: 'Hasil Rekomendasi Olahraga',
                  onTap: () {
                    goTo(context, const SportRecommendationListView());
                  },
                ),
                const ProfileListTile(
                  icon: Icons.fastfood_outlined,
                  text: 'Hasil Rekomendasi Makanan',
                ),
                const ProfileListTile(
                  icon: Icons.privacy_tip,
                  text: 'Kebijakan Privasi',
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
    final googleSignIn = GoogleSignIn();
    bool isUserSignedInWithGoogle = await googleSignIn.isSignedIn();
    try {
      if (isUserSignedInWithGoogle) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut().then((value) {
        goReplacementNamed(context, AppRoute.login);
      });
    } catch (e) {
      log('Error: $e');
    }
  }
}
