part of 'home_cubit.dart';


class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.pokemons = const <Pokemon>[],
    this.hasReachedMax = false,
  });

  final HomeStatus status;
  final List<Pokemon> pokemons;
  final bool hasReachedMax;

  HomeState copyWith({
    HomeStatus? status,
    List<Pokemon>? pokemons,
    bool? hasReachedMax,
  }) {
    return HomeState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''HomeState { status: $status, hasReachedMax: $hasReachedMax, posts: ${pokemons.length} }''';
  }

  @override
  List<Object> get props => [status, pokemons, hasReachedMax];
}
