import 'dart:async';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/animated_logo.dart';

class PokemonListView extends StatefulWidget {
  final List<Pokemon> pokemons;
  final FutureOr<void> Function(Pokemon)? onLike;
  final FutureOr<void> Function()? onPaginate;
  final bool hasReachedMax;

  const PokemonListView({
    Key? key,
    required this.pokemons,
    this.onPaginate,
    required this.hasReachedMax,
    this.onLike,
  }) : super(key: key);

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final _scrollController = ScrollController();
  bool paginating = false;

  @override
  void initState() {
    if (widget.onPaginate != null) {
      _scrollController.addListener(_onScroll);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.hasReachedMax ? widget.pokemons.length : widget.pokemons.length + 1,
      itemBuilder: (context, index) {
        if (index >= widget.pokemons.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: AnimatedLogo(
                isAnimating: true,
                width: 40,
                height: 40,
              ),
            ),
          );
        }
        return PokemonListTile(
          pokemon: widget.pokemons[index],
          onLike: widget.onLike == null ? null : () => widget.onLike?.call(widget.pokemons[index]),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_isBottom && !paginating) {
      paginating = true;
      await widget.onPaginate?.call();
      paginating = false;
    }
  }

  bool get _isBottom {
    if (_scrollController.position.pixels != 0 && _scrollController.position.atEdge) return true;
    return false;
  }
}

class PokemonListTile extends StatelessWidget {
  final Pokemon pokemon;
  final FutureOr<void> Function()? onLike;
  const PokemonListTile({
    super.key,
    required this.pokemon,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pokemon.name[0].toUpperCase() + pokemon.name.substring(1)),
      trailing: onLike == null
          ? null
          : SizedBox(
              width: 50,
              child: LikeButton(
                likeCount: null,
                isLiked: pokemon.isLiked,
                circleColor: CircleColor(start: Theme.of(context).colorScheme.primary, end: Theme.of(context).colorScheme.primary),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Theme.of(context).colorScheme.primary,
                  dotSecondaryColor: Theme.of(context).colorScheme.primary,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite_rounded,
                    color: isLiked ? Theme.of(context).colorScheme.primary : Colors.grey,
                  );
                },
                onTap: (isLiked) async {
                  await onLike?.call();
                  return !isLiked;
                },
              ),
            ),
    );
  }
}
