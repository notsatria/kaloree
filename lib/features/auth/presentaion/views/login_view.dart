import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/colors.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/utils/platform/app_route.dart';
import 'package:kaloree/core/utils/platform/assets.dart';
import 'package:kaloree/core/widgets/custom_button.dart';
import 'package:kaloree/core/widgets/custom_form_field.dart';
import 'package:kaloree/core/widgets/dialog.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showBackDialog(context);
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildImageHeader(),
            _buildLoginViewColumn(context),
          ],
        ),
      ),
    );
  }

  Align _buildLoginViewColumn(BuildContext context) {
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
                'Login',
                style: interBold.copyWith(fontSize: 32),
              ),
              const Gap(4),
              Text(
                'Hai, Selamat datang kembali!',
                style: interRegular.copyWith(fontSize: 14),
              ),
              const Gap(35),
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
              const Gap(8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Lupa Password?',
                    style: interRegular.copyWith(
                      fontSize: 14,
                      color: lightColorScheme.primary,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              CustomFilledButton(
                text: 'Masuk',
                backgroundColor: onBoardingBackgroundColor,
                textColor: Colors.white,
                onTap: () {
                  goToNamed(context, AppRoute.personalInformation);
                },
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
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: interRegular.copyWith(
                      fontSize: 14,
                      color: lightColorScheme.outline,
                    ),
                  ),
                  const Gap(4),
                  TextButton(
                    onPressed: () {
                      goReplacementNamed(context, AppRoute.register);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Daftar Sekarang',
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
