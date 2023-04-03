import 'dart:async';
import 'dart:developer';

import 'package:pokedex_app_flutter/app/data/models/pokedex_response_model.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';
import 'package:pokedex_app_flutter/core/constants.dart';
import 'package:pokedex_app_flutter/core/faliure.dart';
import 'package:pokedex_app_flutter/services/http_service.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final HttpService _httpService;
  final StreamedList<Pokemon> _streamedList = StreamedList<Pokemon>();
  PokedexResponseModel? _previousResponseModel;

  PokemonRepositoryImpl({required HttpService httpService}) : _httpService = httpService;

  @override
  Future<void> likePokemon(Pokemon pokemon) {
    throw UnimplementedError();
  }

  @override
  Future<void> getPaginatedPokemons() async {
    if (!hasReachedMax) {
      log('Requesting pokemons from ');
      try {
        PokedexResponseModel responseModel = await _requestPokemons(_previousResponseModel?.next ?? kPokedexUrl);
        _previousResponseModel = responseModel;
        for (final result in responseModel.results) {
          final pokemon = Pokemon(
            name: result.name,
            isLiked: false,
          );
          _streamedList.addToList(pokemon);
        }
      } catch (e) {
        throw Failure(message: kGenericErrorMessage);
      }
    }
  }

  Future<PokedexResponseModel> _requestPokemons(String url) async {
    final response = await _httpService.request<Map<String, dynamic>>(RequestMethod.get, url);
    final responseModel = PokedexResponseModel.fromJson(response.data!);
    _previousResponseModel = responseModel;
    return responseModel;
  }

  @override
  Stream<List<Pokemon>> get pokemons => _streamedList.data;

  @override
  void dispose() {
    _streamedList.dispose();
  }

  @override
  bool get hasReachedMax => _previousResponseModel != null && _previousResponseModel!.next == null;
}

class StreamedList<T> {
  StreamController<List<T>> _controller = StreamController.broadcast();

  Stream<List<T>> get data => _controller.stream;

  List<T> _list = [];

  void updateList(List<T> list) {
    _list = list;
    _dispatch();
  }

  void addToList(T value) {
    _list.add(value);
    _dispatch();
  }

  void _dispatch() {
    _controller.sink.add(_list);
  }

  void dispose() {
    _controller.close();
  }
}
