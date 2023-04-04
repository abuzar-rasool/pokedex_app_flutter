import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/entities/favourite_status.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';

import '../../../core/faliure.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final PokemonRepository _pokemonRepository;
  final AuthenticationRepository _authenticationRepository;
  FavouriteCubit({
    required PokemonRepository pokemonRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _pokemonRepository = pokemonRepository, _authenticationRepository = authenticationRepository,
        super(const FavouriteState());

  Future<void> loadFavourites() async {
    try {
      await _pokemonRepository.getLikedPokemons(_authenticationRepository.getLoggedInUser!.id);
      emit(state.copyWith(status: FavouriteStatus.sucess, pokemons: [..._pokemonRepository.likedPokemons]));
    } on Failure catch (_) {
      emit(state.copyWith(status: FavouriteStatus.failure));
    }
  }
}
