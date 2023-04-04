import 'package:flutter/material.dart';
import 'package:pokedex_app_flutter/core/constants.dart';

class FavouriteScreenErrorView extends StatelessWidget {
  const FavouriteScreenErrorView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(kGenericErrorMessage),
    );
  }
}
