import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/main_menu/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:kaloree/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:kaloree/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/custom_color.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/utils/platform/app_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightScheme;
      ColorScheme darkScheme;

      if (lightDynamic != null && darkDynamic != null) {
        lightScheme = lightDynamic.harmonized();
        lightCustomColors = lightCustomColors.harmonized(lightScheme);

        // Repeat for the dark color scheme.
        darkScheme = darkDynamic.harmonized();
        darkCustomColors = darkCustomColors.harmonized(darkScheme);
      } else {
        // Otherwise, use fallback schemes.
        lightScheme = lightColorScheme;
        darkScheme = darkColorScheme;
      }

      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => OnBoardingCubit(0)),
          BlocProvider(create: (context) => BottomNavigationCubit()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Inter',
            colorScheme: lightScheme,
            extensions: [lightCustomColors],
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: lightColorScheme.primary,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xffEAEAEA),
              elevation: 0,
              iconTheme:
                  IconThemeData(color: lightColorScheme.outline, size: 20),
              centerTitle: true,
              titleTextStyle:
                  interMedium.copyWith(fontSize: 14, color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Inter',
            colorScheme: darkScheme,
            extensions: [darkCustomColors],
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: darkColorScheme.primary,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xffEAEAEA),
              elevation: 0,
              iconTheme:
                  IconThemeData(color: darkColorScheme.outline, size: 20),
              centerTitle: true,
              titleTextStyle: interMedium.copyWith(
                  fontSize: 14, color: darkColorScheme.onPrimary),
            ),
          ),
          home: const OnBoardingView(),
          initialRoute: AppRoute.onboarding,
          onGenerateRoute: AppRoute.onGenerateRoute,
        ),
      );
    });
  }
}
