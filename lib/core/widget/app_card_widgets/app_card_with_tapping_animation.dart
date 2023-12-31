import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'app_card.dart';

import '../animations/animated_button_tapping.dart';

class AppCardWithTappingAnimation extends StatelessWidget {
  const AppCardWithTappingAnimation({
    super.key,
    required this.child,
    required this.onTap,
    required this.onTapUp,
    required this.canTap,
    this.useMargin = false,
  });
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback onTapUp;
  final bool useMargin;
  final bool canTap;
  @override
  Widget build(BuildContext context) {
    return AnimatedButtonTapping(
      onTap: canTap ? onTap : null,
      onTapUp: canTap ? onTapUp : null,
      child: AppCard(
        useMargin: useMargin,
        decoration: canTap ? null : AppDecorations.zikrCardAfterTappingEnd(context),
        child: child,
      ),
    );
  }
}
