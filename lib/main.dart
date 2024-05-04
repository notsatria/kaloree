import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/theme/app_theme.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/custom_color.g.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/features/main_menu/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:kaloree/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:kaloree/features/onboarding/presentation/views/onboarding_view.dart';

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
          theme: AppTheme.lightTheme(lightScheme),
          darkTheme: AppTheme.darkTheme(darkScheme),
          home: const OnBoardingView(),
          initialRoute: AppRoute.onboarding,
          onGenerateRoute: AppRoute.onGenerateRoute,
        ),
      );
    });
  }
}
