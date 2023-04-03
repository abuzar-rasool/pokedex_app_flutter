import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_app_flutter/app/cubits/authentication/authentication_cubit.dart';
import 'package:pokedex_app_flutter/app/entities/authentication_status.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/home/home_screen.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/login/login_screen.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/register/register_screen.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/splash/splash_screen.dart';
import 'package:pokedex_app_flutter/core/app_navigator/fade_page_route.dart';

enum Routes { splash, home, login, register }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.login: _Paths.login,
    Routes.register: _Paths.register,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case _Paths.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case _Paths.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case _Paths.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) => state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) => state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;

  static navigate(AuthenticationStatus authenticationStatus){
    switch (authenticationStatus) {
      case AuthenticationStatus.authenticated:
        replaceWith(Routes.home);
        break;
      case AuthenticationStatus.unauthenticated:
        replaceWith(Routes.login);
        break;
      default:
        replaceWith(Routes.splash);
    }
  }
}
