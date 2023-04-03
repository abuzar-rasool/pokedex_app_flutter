import 'package:flutter/material.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/animated_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AnimatedLogo(isAnimating: true, width: 180, height: 180)));
  }
}
