import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/utils/show_snackbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:kaloree/features/profile/presentation/widgets/edit_profile_form_field.dart';

class EditProfileView extends StatefulWidget {
  final UserModel user;
  const EditProfileView({super.key, required this.user});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  bool _isLoading = false;

  @override
  void dispose() {
    _isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.user.fullName);

    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileLoading) {
          setState(() {
            _isLoading = true;
          });
        }

        if (state is EditProfileSuccess) {
          Navigator.pop(context, true);
        }

        if (state is EditProfileFailure) {
          showSnackbar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: buildCustomAppBar(
            title: 'Edit Profile',
            context: context,
            canPop: true,
            actions: [
              IconButton(
                  onPressed: () {
                    _showUpdateProfileDialog(context, nameController);
                  },
                  icon: const Icon(Icons.save)),
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: margin_20),
          child: Column(
            children: [
              _isLoading ? const LinearProgressIndicator() : const SizedBox(),
              const Gap(12),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      '${widget.user.profilePicture}',
                      fit: BoxFit.cover,
                      width: 120,
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
              const Gap(70),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nama Lengkap',
                  style: interMedium.copyWith(fontSize: 16),
                ),
              ),
              const Gap(8),
              EditProfileFormField(
                hintText: 'Nama Lengkap',
                controller: nameController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateProfileDialog(
      BuildContext context, TextEditingController nameController) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Simpan'),
            content: const Text('Apakah Anda yakin ingin menyimpan perubahan?'),
            actions: [
              TextButton(
                onPressed: () {
                  pop(context);
                },
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () {
                  pop(context);
                  context
                      .read<EditProfileBloc>()
                      .add(EditProfile(nameController.text));
                },
                child: const Text('Yakin'),
              ),
            ],
          );
        });
  }
}
