import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/features/auth/presentaion/widgets/custom_form_field.dart';
import 'package:kaloree/theme/color_schemes.g.dart';
import 'package:kaloree/theme/colors.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:kaloree/utils/platform/app_route.dart';
import 'package:kaloree/utils/platform/assets.dart';
import 'package:kaloree/widgets/custom_button.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _showBackDialog(context);
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildImageHeader(),
            _buildRegisterViewColumn(context),
          ],
        ),
      ),
    );
  }

  void _showBackDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar dari Kaloree?'),
          content: const Text(
            'Kamu yakin keluar dari Kaloree?',
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
              child: const Text('Keluar'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  Align _buildRegisterViewColumn(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: getMaxHeight(context) * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: margin_20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(35),
              Text(
                'Register',
                style: interBold.copyWith(fontSize: 32),
              ),
              const Gap(4),
              Text(
                'Hai, Selamat datang di Kaloree!',
                style: interRegular.copyWith(fontSize: 14),
              ),
              const Gap(50),
              Text(
                'Email',
                style: interMedium.copyWith(fontSize: 16),
              ),
              const Gap(8),
              const CustomFormField(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.email_outlined,
              ),
              const Gap(18),
              Text(
                'Password',
                style: interMedium.copyWith(fontSize: 16),
              ),
              const Gap(8),
              CustomFormField(
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: lightColorScheme.outline,
                ),
                obscureText: true,
              ),
              const Gap(18),
              Text(
                'Konfirmasi Password',
                style: interMedium.copyWith(fontSize: 16),
              ),
              const Gap(8),
              CustomFormField(
                hintText: 'Konfirmasi Password',
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: lightColorScheme.outline,
                ),
                obscureText: true,
              ),
              const Gap(20),
              CustomFilledButton(
                text: 'Daftar',
                backgroundColor: onBoardingBackgroundColor,
                textColor: Colors.white,
                onTap: () {},
              ),
              const Gap(24),
              Row(
                children: [
                  const Expanded(
                    child: Divider(),
                  ),
                  const Gap(8),
                  Text(
                    'Atau',
                    style: interMedium.copyWith(fontSize: 12),
                  ),
                  const Gap(8),
                  const Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              const Gap(24),
              CustomOutlinedButton(
                text: 'Masuk dengan Google',
                onTap: () {},
                outlineColor: lightColorScheme.outline,
                textColor: lightColorScheme.outline,
                outlineWidth: 2,
                leadingIcon: FaIcon(
                  FontAwesomeIcons.google,
                  color: lightColorScheme.outline,
                ),
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun?',
                    style: interRegular.copyWith(
                      fontSize: 14,
                      color: lightColorScheme.outline,
                    ),
                  ),
                  const Gap(4),
                  TextButton(
                    onPressed: () {
                      goReplacementNamed(context, AppRoute.login);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Masuk',
                      style: interRegular.copyWith(
                        fontSize: 14,
                        color: lightColorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image _buildImageHeader() {
    return Image.asset(
      headerArt,
    );
  }
}
