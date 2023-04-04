import 'package:flutter/material.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/animated_logo.dart';

class FovouriteScreenLoadingView extends StatelessWidget {
  const FovouriteScreenLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AnimatedLogo(
        isAnimating: true,
        width: 40,
        height: 40,
      ),
    );
  }
}
