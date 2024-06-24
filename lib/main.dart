import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/app_theme.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/custom_color.g.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/assesment/presentation/bloc/assesment_bloc.dart';
import 'package:kaloree/features/assesment/presentation/views/personal_information_view.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_error_view.dart';
import 'package:kaloree/features/auth/presentaion/bloc/auth_bloc.dart';
import 'package:kaloree/features/catatan/presentation/bloc/catatan_bloc.dart';
import 'package:kaloree/features/history/presentation/bloc/get_total_calories_in_week_bloc.dart';
import 'package:kaloree/features/home/presentation/bloc/daily_calories_bloc.dart';
import 'package:kaloree/features/home/presentation/bloc/user_home_bloc.dart';
import 'package:kaloree/features/main_menu/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:kaloree/features/main_menu/presentation/views/main_view.dart';
import 'package:kaloree/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:kaloree/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:kaloree/features/scan/presentation/bloc/image_classification_bloc.dart';
import 'package:kaloree/firebase_options.dart';
import 'package:kaloree/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();

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
          BlocProvider<AuthBloc>(
              create: (context) => serviceLocator<AuthBloc>()),
          BlocProvider<AssesmentBloc>(
              create: (context) => serviceLocator<AssesmentBloc>()),
          BlocProvider<ImageClassificationBloc>(
              create: (context) => serviceLocator<ImageClassificationBloc>()),
          BlocProvider<CatatanBloc>(
              create: (context) => serviceLocator<CatatanBloc>()),
          BlocProvider<UserHomeBloc>(
              create: (context) => serviceLocator<UserHomeBloc>()),
          BlocProvider<DailyCaloriesBloc>(
              create: (context) => serviceLocator<DailyCaloriesBloc>()),
          BlocProvider<GetTotalCaloriesInWeekBloc>(
              create: (context) =>
                  serviceLocator<GetTotalCaloriesInWeekBloc>()),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme(lightScheme),
          darkTheme: AppTheme.darkTheme(darkScheme),
          home: FutureBuilder<Widget>(
            future: _checkUserSignedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Loading());
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: ErrorView(message: snapshot.error.toString()),
                );
              } else {
                return snapshot.data ?? const OnBoardingView();
              }
            },
          ),
          initialRoute: AppRoute.onboarding,
          onGenerateRoute: AppRoute.onGenerateRoute,
        ),
      );
    });
  }

  Future<Widget> _checkUserSignedIn() async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    if (auth.currentUser != null) {
      bool isAssesmentComplete = await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((doc) => doc['isAssesmentComplete'] as bool? ?? false);

      if (isAssesmentComplete) {
        return const MainView();
      } else {
        return const PersonalInformationView();
      }
    } else {
      return const OnBoardingView();
    }
  }
}
