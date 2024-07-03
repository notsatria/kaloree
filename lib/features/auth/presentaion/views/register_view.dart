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

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoadingOnSignInWithEmailAndPassword = false;
  bool _isLoadingOnSignInWithGoogle = false;
  bool _isObscurePass = true;
  bool _isObscureConfPass = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfController.dispose();
    _isLoadingOnSignInWithEmailAndPassword = false;
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
            _buildRegisterViewColumn(context),
          ],
        ),
      ),
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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackbar(
                  context,
                  state.message,
                  backgroundColor: lightColorScheme.error,
                );
              }
              if (state is AuthLoadingOnLoadingWithEmailAndPassword) {
                setState(() {
                  _isLoadingOnSignInWithEmailAndPassword = true;
                });
              } else {
                setState(() {
                  _isLoadingOnSignInWithEmailAndPassword = false;
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

              if (state is AuthRegisterSuccess) {
                goReplacementNamed(context, AppRoute.login);
                showSnackbar(context, "Registrasi akun berhasil!");
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
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
                        }
                        if (!value.contains('@')) {
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
                            _isObscurePass = !_isObscurePass;
                          });
                        },
                        child: Icon(
                          Icons.visibility_off_outlined,
                          color: lightColorScheme.outline,
                        ),
                      ),
                      obscureText: _isObscurePass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        if (value != passwordConfController.text) {
                          return 'Password tidak sama';
                        }
                        return null;
                      },
                    ),
                    const Gap(18),
                    Text(
                      'Konfirmasi Password',
                      style: interMedium.copyWith(fontSize: 16),
                    ),
                    const Gap(8),
                    AuthFormField(
                      controller: passwordConfController,
                      hintText: 'Konfirmasi Password',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isObscureConfPass = !_isObscureConfPass;
                          });
                        },
                        child: Icon(
                          Icons.visibility_off_outlined,
                          color: lightColorScheme.outline,
                        ),
                      ),
                      obscureText: _isObscureConfPass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        if (value != passwordController.text) {
                          return 'Password tidak sama';
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    CustomFilledButton(
                      text: 'Daftar',
                      backgroundColor: onBoardingBackgroundColor,
                      textColor: Colors.white,
                      isLoading: _isLoadingOnSignInWithEmailAndPassword,
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            passwordController.text ==
                                passwordConfController.text) {
                          log('Email: ${emailController.text} and Password: ${passwordController.text}');
                          context.read<AuthBloc>().add(
                                AuthSignUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
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
                      isLoading: _isLoadingOnSignInWithGoogle,
                      onTap: () {
                        context.read<AuthBloc>().add(AuthLoginWithGoogle());
                      },
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
              );
            },
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
