import 'package:pokedex_app_flutter/app/entities/pokemon.dart';

abstract class PokemonRepository {
  List<Pokemon> get pokemons;
  List<Pokemon> get likedPokemons;
  Future<void> getPaginatedPokemons(String userId);
  Future<void> likePokemon(Pokemon pokemon, String userId);
  Future<void> getLikedPokemons(String userId);
  bool get hasReachedMax;
}
