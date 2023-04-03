import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app_flutter/app/cubits/authentication/authentication_cubit.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/firebase_authentication_respository.dart';
import 'package:pokedex_app_flutter/services/http_service.dart';
import 'package:pokedex_app_flutter/services/snackbar_service.dart';

class Injector extends StatelessWidget {
  final Widget child;

  const Injector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return _GlobalServiceInjector(
      child: _GlobalRepositoryInjector(
        child: _GlobalBlocInjector(
          child: child,
        ),
      ),
    );
  }
}

class _GlobalRepositoryInjector extends StatelessWidget {
  final Widget child;

  const _GlobalRepositoryInjector({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(create: (context) => FirebaseAuthRepository()),
      ],
      child: child,
    );
  }
}

class _GlobalBlocInjector extends StatelessWidget {
  final Widget child;

  const _GlobalBlocInjector({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(create: (context) => AuthenticationCubit(authenticationRepository: context.read<AuthenticationRepository>())),
      ],
      child: child,
    );
  }
}


class _GlobalServiceInjector extends StatelessWidget {
  final Widget child;

  const _GlobalServiceInjector({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HttpService>(create: (context) => HttpService()),
        RepositoryProvider<SnackBarService>(create: (context) => SnackBarService()),
      ],
      child: child,
    );
  }
}
