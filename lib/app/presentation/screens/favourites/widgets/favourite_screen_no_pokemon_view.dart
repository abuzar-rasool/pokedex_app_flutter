import 'package:flutter/material.dart';
import 'package:pokedex_app_flutter/core/constants.dart';

class FavouriteScreenNoPokemonView extends StatelessWidget {
  const FavouriteScreenNoPokemonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No favourites yet!'),
    );
  }
}
