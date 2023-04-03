import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';
import 'package:pokedex_app_flutter/core/faliure.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PokemonRepository _pokemonRepository;
  late StreamSubscription<List<Pokemon>> _pokemonSubscription;
  HomeCubit({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository,
        super(const HomeState()) {
    _pokemonSubscription = _pokemonRepository.pokemons.listen(
      (pokemons) => emit(state.copyWith(
        pokemons: pokemons,
        hasReachedMax: _pokemonRepository.hasReachedMax,
        status: HomeStatus.success,
      )),
    );
  }

  @override
  Future<void> close() {
    _pokemonSubscription.cancel();
    return super.close();
  }

  Future<void> loadPokemons() async {
    if (state.hasReachedMax) return;
    try {
      log('Requesting pokemons from ');
      await _pokemonRepository.getPaginatedPokemons();
      state.copyWith(status: HomeStatus.success);
    } on Failure catch (_) {
      state.copyWith(status: HomeStatus.failure);
    }
  }
}
