import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:kaloree/features/onboarding/presentation/views/widgets/onboarding_widget.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/colors.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: onBoardingBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<OnBoardingCubit, int>(
        builder: (context, state) {
          final pages = context.read<OnBoardingCubit>().pages;
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: margin_20),
                  child: Row(
                    children: [
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: pages.length,
                        effect: ExpandingDotsEffect(
                            activeDotColor: Colors.white,
                            dotColor: lightColorScheme.outline,
                            dotHeight: 8),
                      ),
                      const Spacer(),
                      _buildSkipButton(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: margin_20),
                    child: OnBoardingWidget(
                        title: pages[state]['title'],
                        description: pages[state]['description'],
                        image: pages[state]['image']),
                  ),
                  onPageChanged: (value) {
                    context.read<OnBoardingCubit>().nextPage(value);
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: margin_20),
                  child: Column(
                    children: [
                      CustomFilledButton(
                        text: 'Daftar Sekarang',
                        backgroundColor: Colors.white,
                        textColor: lightColorScheme.primary,
                        onTap: () {
                          goReplacementNamed(context, AppRoute.login);
                        },
                      ),
                      const Gap(13),
                      CustomOutlinedButton(
                        text: 'Masuk dengan Google',
                        onTap: () {},
                        outlineColor: Colors.white,
                        textColor: Colors.white,
                        outlineWidth: 3,
                        leadingIcon: const FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  TextButton _buildSkipButton() {
    return TextButton(
      onPressed: () {
        goReplacementNamed(context, AppRoute.login);
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
      child: const Row(
        children: [
          Text('Skip'),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
        ],
      ),
    );
  }
}
