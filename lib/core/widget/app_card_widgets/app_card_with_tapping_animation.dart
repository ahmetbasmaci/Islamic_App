import 'package:flutter/material.dart';
import 'app_card.dart';

import '../animations/animated_button_tapping.dart';

class AppCardWithTappingAnimation extends StatelessWidget {
  const AppCardWithTappingAnimation({
    super.key,
    required this.child,
    required this.onTap,
    required this.onTapUp,
    this.useMargin = false,
    this.boxShadow,
  });
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onTapUp;
  final bool useMargin;
  final BoxShadow? boxShadow;
  @override
  Widget build(BuildContext context) {
    return AnimatedButtonTapping(
      onTap: onTap,
      onTapUp: onTapUp,
      child: AppCard(
        useMargin: useMargin,
        boxShadow:boxShadow,
        child: child,
      ),
    );
  }
}
