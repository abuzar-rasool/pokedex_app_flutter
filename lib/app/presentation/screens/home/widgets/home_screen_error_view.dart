import 'package:flutter/material.dart';
import 'package:pokedex_app_flutter/core/constants.dart';

class HomeScreenErrorView extends StatelessWidget {
  const HomeScreenErrorView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(kGenericErrorMessage),
    );
  }
}
