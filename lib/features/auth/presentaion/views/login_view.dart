import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/colors.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/utils/show_snackbar.dart';
import 'package:kaloree/core/widgets/custom_button.dart';
import 'package:kaloree/core/widgets/dialog.dart';
import 'package:kaloree/features/auth/presentaion/bloc/auth_bloc.dart';
import 'package:kaloree/features/auth/presentaion/widgets/auth_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoadingSignInWithEmail = false;
  bool _isLoadingOnSignInWithGoogle = false;
  bool _isObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _isLoadingSignInWithEmail = false;
    _isLoadingOnSignInWithGoogle = false;
    super.dispose();
  }

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
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            }
            if (state is AuthLoadingOnLoadingWithEmailAndPassword) {
              setState(() {
                _isLoadingSignInWithEmail = true;
              });
            } else {
              setState(() {
                _isLoadingSignInWithEmail = false;
              });
            }

            if (state is AuthLoadingOnLoadingWithGoogle) {
              setState(() {
                _isLoadingOnSignInWithGoogle = true;
              });
            } else {
              setState(() {
                _isLoadingOnSignInWithGoogle = false;
              });
            }

            if (state is AuthLoginSuccess) {
              final user = state.user;
              if (user.isAssesmentComplete == true) {
                goReplacementNamed(context, AppRoute.main);
                return;
              }
              goReplacementNamed(context, AppRoute.personalInformation);
              showSnackbar(
                context,
                'Selamat datang!',
                backgroundColor: lightColorScheme.primary,
              );
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  AuthFormField(
                    controller: emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      } else if (!value.contains('@')) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const Gap(18),
                  Text(
                    'Password',
                    style: interMedium.copyWith(fontSize: 16),
                  ),
                  const Gap(8),
                  AuthFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      child: Icon(
                        Icons.visibility_off_outlined,
                        color: lightColorScheme.outline,
                      ),
                    ),
                    obscureText: _isObscure,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
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
                    isLoading: _isLoadingSignInWithEmail,
                    text: 'Masuk',
                    backgroundColor: onBoardingBackgroundColor,
                    textColor: Colors.white,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignIn(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                        log('Login success');
                      }
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
                    onTap: () {
                      context.read<AuthBloc>().add(AuthLoginWithGoogle());
                    },
                    isLoading: _isLoadingOnSignInWithGoogle,
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
