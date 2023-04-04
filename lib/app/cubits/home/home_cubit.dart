import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';
import 'package:pokedex_app_flutter/core/faliure.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PokemonRepository _pokemonRepository;
  final AuthenticationRepository _authenticationRepository;
  HomeCubit({required PokemonRepository pokemonRepository, required AuthenticationRepository authenticationRepository})
      : _pokemonRepository = pokemonRepository,
        _authenticationRepository = authenticationRepository,
        super(const HomeState());

  Future<void> loadPokemons() async {
    if (state.hasReachedMax) return;
    try {
      log('Requesting pokemons from ');
      await _pokemonRepository.getPaginatedPokemons(_authenticationRepository.getLoggedInUser!.id);
      emit(state.copyWith(status: HomeStatus.success, pokemons: [..._pokemonRepository.pokemons], hasReachedMax: _pokemonRepository.hasReachedMax));
    } on Failure catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> likePokemon(Pokemon pokemon) async {
    try {
      await _pokemonRepository.likePokemon(pokemon, _authenticationRepository.getLoggedInUser!.id);
      emit(state.copyWith(status: HomeStatus.success, pokemons: [..._pokemonRepository.pokemons]));
    } on Failure catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
