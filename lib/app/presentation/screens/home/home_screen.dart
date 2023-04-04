// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex_app_flutter/app/cubits/home/home_cubit.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository_impl.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/home/widgets/home_screen_loaded_view.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/animated_logo.dart';
import 'package:pokedex_app_flutter/core/constants.dart';
import 'package:pokedex_app_flutter/services/http_service.dart';
import 'package:pokedex_app_flutter/services/local_storage_service.dart';
import 'package:pokedex_app_flutter/services/snackbar_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthenticationRepository>().logout();
            },
          ),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))],
        ),
        body: BlocProvider(
          create: (context) => HomeCubit(
            authenticationRepository: context.read<AuthenticationRepository>(),
            pokemonRepository: PokemonRepositoryImpl(
              httpService: context.read<HttpService>(),
              localStorageService: context.read<LocalStorageService>(),
            ),
          )..loadPokemons(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state.status == HomeStatus.failure) {
                context.read<SnackBarService>().showGenericErrorSnackBar(context);
              }
            },
            builder: (context, state) {
              if (state.status == HomeStatus.initial) {
                return const Center(
                  child: AnimatedLogo(
                    isAnimating: true,
                    width: 40,
                    height: 40,
                  ),
                );
              } else if (state.pokemons.isEmpty) {
                return Center(
                  child: Text(kGenericErrorMessage),
                );
              } else {
                return HomeScreenLoadedView(
                  pokemons: state.pokemons,
                  onPaginate: () async => await context.read<HomeCubit>().loadPokemons(),
                  hasReachedMax: state.hasReachedMax,
                  key: const Key('home_screen_loaded_view'),
                  onLike: (pokemon) async => await context.read<HomeCubit>().likePokemon(pokemon),
                );
              }
            },
          ),
        ));
  }
}
