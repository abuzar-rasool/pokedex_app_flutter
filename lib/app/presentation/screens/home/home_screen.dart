import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app_flutter/app/cubits/home/home_cubit.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/entities/home_status.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/home/widgets/home_screen_error_view.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/home/widgets/home_screen_loading_view.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/pokemon_list_view.dart';
import 'package:pokedex_app_flutter/core/app_navigator/app_navigator.dart';
import 'package:pokedex_app_flutter/services/snackbar_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        authenticationRepository: context.read<AuthenticationRepository>(),
        pokemonRepository: context.read<PokemonRepository>(),
      )..loadPokemons(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            context.read<SnackBarService>().showGenericErrorSnackBar(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Home'),
              leading: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => context.read<HomeCubit>().logout(),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      AppNavigator.push(Routes.favourites);
                    },
                    icon: const Icon(Icons.favorite_border))
              ],
            ),
            body: _builScreenWidget(context, state),
          );
        },
      ),
    );
  }

  Widget _builScreenWidget(BuildContext context, HomeState state) {
    if (state.status == HomeStatus.initial) {
      return const HomeScreenLoadingView();
    } else if (state.pokemons.isEmpty) {
      return const HomeScreenErrorView();
    } else {
      return PokemonListView(
        pokemons: state.pokemons,
        onPaginate: () async => await context.read<HomeCubit>().loadPokemons(),
        hasReachedMax: state.hasReachedMax,
        key: const Key('home_screen_pokemon_list'),
        onLike: (pokemon) async => await context.read<HomeCubit>().likePokemon(pokemon),
      );
    }
  }
}
