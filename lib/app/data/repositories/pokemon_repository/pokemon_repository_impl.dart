import 'dart:async';
import 'dart:developer';

import 'package:pokedex_app_flutter/app/data/models/pokedex_response_model.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';
import 'package:pokedex_app_flutter/core/constants.dart';
import 'package:pokedex_app_flutter/core/faliure.dart';
import 'package:pokedex_app_flutter/services/http_service.dart';
import 'package:pokedex_app_flutter/services/local_storage_service.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final HttpService _httpService;
  final LocalStorageService _localStorageService;
  final List<Pokemon> _pokemons = [];
  final List<String> _likedPokemons = [];
  PokedexResponseModel? _previousResponseModel;

  PokemonRepositoryImpl({
    required HttpService httpService,
    required LocalStorageService localStorageService,
  })  : _httpService = httpService,
        _localStorageService = localStorageService;

  @override
  Future<void> likePokemon(Pokemon pokemon, String userId) async {
    try {
      if (_likedPokemons.contains(pokemon.name)) {
        _likedPokemons.remove(pokemon.name);
        await _localStorageService.removeStringListItem(userId, pokemon.name);
      } else {
        _likedPokemons.add(pokemon.name);
        await _localStorageService.addStringListItem(userId, pokemon.name);
      }
      int index = _pokemons.indexWhere((element) => element.name == pokemon.name);
      _pokemons[index] = pokemon.copyWith(isLiked: !pokemon.isLiked);
    } catch (e) {
      throw Failure(message: kGenericErrorMessage);
    }
  }

  @override
  Future<void> getPaginatedPokemons(String userId) async {
    if (!hasReachedMax) {
      try {
        PokedexResponseModel responseModel = await _requestPokemons(_previousResponseModel?.next ?? kPokedexUrl);
        _previousResponseModel = responseModel;
        List<Pokemon> pokemons = responseModel.results.map((e) => Pokemon(name: e.name, isLiked: _likedPokemons.contains(e.name))).toList();
        _pokemons.addAll(pokemons);
      } catch (e) {
        throw Failure(message: kGenericErrorMessage);
      }
    }
  }
  @override
  Future<void> getLikedPokemons(String userId) async {
    try {
      List<String> likedPokemonsString = await _localStorageService.getStringList(userId);
      _likedPokemons.clear();
      _likedPokemons.addAll(likedPokemonsString);
    } catch (e) {
      throw Failure(message: kGenericErrorMessage);
    }
  }

  Future<PokedexResponseModel> _requestPokemons(String url) async {
    final response = await _httpService.request<Map<String, dynamic>>(RequestMethod.get, url);
    final responseModel = PokedexResponseModel.fromJson(response.data!);
    _previousResponseModel = responseModel;
    return responseModel;
  }

  @override
  List<Pokemon> get pokemons => _pokemons;

  @override
  bool get hasReachedMax => _previousResponseModel != null && _previousResponseModel!.next == null;

  @override
  List<Pokemon> get likedPokemons => _likedPokemons.map((e) => Pokemon(name: e, isLiked: true)).toList();
}
