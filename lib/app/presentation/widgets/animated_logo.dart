import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  final bool isAnimating;
  final double width;
  final double height;
  const AnimatedLogo({
    Key? key,
    required this.isAnimating,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isAnimating
        ? RotationTransition(
            turns: CurveTween(curve: Curves.easeInOutCubic).animate(_controller),
            child: Image.asset('assets/images/logo.png', width: widget.width, height: widget.height),
          )
        : Image.asset('assets/images/logo.png', width: widget.width, height: widget.height);
  }
}
