import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:pokedex_app_flutter/app/cubits/authentication/authentication_cubit.dart';
import 'package:pokedex_app_flutter/core/app_navigator/app_navigator.dart';
import 'package:pokedex_app_flutter/services/injector.dart';
import 'package:pokedex_app_flutter/core/pokedex_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Injector(
      child: FlutterWebFrame(
          maximumSize: const Size.fromWidth(600),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          enabled: kIsWeb || !Platform.isAndroid && !Platform.isIOS,
          builder: (context) {
            return MaterialApp(
              title: 'Pokedex App',
              debugShowCheckedModeBanner: false,
              navigatorKey: AppNavigator.navigatorKey,
              onGenerateRoute: AppNavigator.onGenerateRoute,
              theme: PokedexTheme.theme,
              builder: (context, child) {
                return BlocListener<AuthenticationCubit, AuthenticationState>(
                  listener: (context, state) => AppNavigator.navigate(state.status),
                  child: child,
                );
              },
            );
          }),
    );
  }
}
