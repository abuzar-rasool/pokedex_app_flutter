import 'dart:async';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/animated_logo.dart';

class HomeScreenLoadedView extends StatefulWidget {
  final List<Pokemon> pokemons;
  final FutureOr<void> Function(Pokemon) onLike;
  final FutureOr<void> Function() onPaginate;
  final bool hasReachedMax;

  const HomeScreenLoadedView({
    Key? key,
    required this.pokemons,
    required this.onPaginate,
    required this.hasReachedMax,
    required this.onLike,
  }) : super(key: key);

  @override
  State<HomeScreenLoadedView> createState() => _HomeScreenLoadedViewState();
}

class _HomeScreenLoadedViewState extends State<HomeScreenLoadedView> {
  final _scrollController = ScrollController();
  bool paginating = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
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
          onLike: () => widget.onLike(widget.pokemons[index]),
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
      await widget.onPaginate();
      paginating = false;
      setState(() {});
    }
  }

  bool get _isBottom {
    if (_scrollController.position.pixels != 0 && _scrollController.position.atEdge) return true;
    return false;
  }
}

class PokemonListTile extends StatelessWidget {
  final Pokemon pokemon;
  final FutureOr<void> Function() onLike;
  const PokemonListTile({
    super.key,
    required this.pokemon,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pokemon.name[0].toUpperCase() + pokemon.name.substring(1)),
      trailing: SizedBox(
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
            await onLike();
            return !isLiked;
          },
        ),
      ),
    );
  }
}
