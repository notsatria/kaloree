import 'package:flutter/material.dart';
import 'package:kaloree/features/assesment/presentation/views/personal_information.dart';
import 'package:kaloree/features/auth/presentaion/views/login_view.dart';
import 'package:kaloree/features/auth/presentaion/views/register_view.dart';
import 'package:kaloree/features/onboarding/presentation/views/onboarding_view.dart';

class AppRoute {
  static const onboarding = '/';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const personalInformation = '/personal-information';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const OnBoardingView(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginView(),
          settings: settings,
        );
      case register:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const RegisterView(),
          settings: settings,
        );
        case personalInformation:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const PersonalInformationView(),
          settings: settings,
        );
      default:
        return _notFoundRoute(settings);
    }
  }

  static MaterialPageRoute _notFoundRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page Not Found'),
        ),
      ),
      settings: settings,
    );
  }
}

void goTo(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}

void goReplacement(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => page),
  );
}

void goToNamed(BuildContext context, String route, {Object? arguments}) {
  Navigator.of(context).pushNamed(route, arguments: arguments);
}

void goReplacementNamed(BuildContext context, String route,
    {Object? arguments}) {
  Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
}

void pop(BuildContext context) {
  Navigator.of(context).pop();
}