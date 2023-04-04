import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app_flutter/app/cubits/favourites/favourite_cubit.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/entities/favourite_status.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/favourites/widgets/favourite_screen_error_view.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/favourites/widgets/favourite_screen_no_pokemon_view.dart';
import 'package:pokedex_app_flutter/app/presentation/screens/favourites/widgets/favuorite_screen_loading_view.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/pokemon_list_view.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit(
        pokemonRepository: context.read<PokemonRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      )..loadFavourites(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
        ),
        body: BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            if (state.status == FavouriteStatus.initial) {
              return const FovouriteScreenLoadingView();
            } else if (state.status == FavouriteStatus.failure) {
              return const FavouriteScreenErrorView();
            } else if (state.favouritePokemons.isEmpty) {
              return const FavouriteScreenNoPokemonView();
            }
            return PokemonListView(pokemons: state.favouritePokemons, hasReachedMax: true);
          },
        ),
      ),
    );
  }
}
