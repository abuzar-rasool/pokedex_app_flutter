part of 'favourite_cubit.dart';

class FavouriteState extends Equatable {
  const FavouriteState({
    this.status = FavouriteStatus.initial,
    this.favouritePokemons = const <Pokemon>[],
  });

  final FavouriteStatus status;
  final List<Pokemon> favouritePokemons;

  FavouriteState copyWith({
    FavouriteStatus? status,
    List<Pokemon>? pokemons,
  }) {
    return FavouriteState(
      status: status ?? this.status,
      favouritePokemons: pokemons ?? favouritePokemons,
    );
  }

  @override
  String toString() {
    return '''FavouritwState { status: $status, posts: ${favouritePokemons.length} }''';
  }

  @override
  List<Object> get props => [status, favouritePokemons];
}
