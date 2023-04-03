import 'package:pokedex_app_flutter/app/entities/pokemon.dart';

abstract class PokemonRepository {
  Stream<List<Pokemon>> get pokemons;
  Future<void> getPaginatedPokemons();
  Future<void> likePokemon(Pokemon pokemon);
  void dispose();
  bool get hasReachedMax;
}
