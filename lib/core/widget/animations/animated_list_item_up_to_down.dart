import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedListItemUpToDown extends StatelessWidget {
  const AnimatedListItemUpToDown({
    super.key,
    required this.index,
    required this.child,
    this.staggerDuration,
    this.slideDuration,
    this.scaleDuration,
  });
  final int index;
  final Widget child;
  final Duration? staggerDuration;
  final Duration? slideDuration;
  final Duration? scaleDuration;
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: staggerDuration ?? const Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: slideDuration ?? const Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
        verticalOffset: -250,
        child: ScaleAnimation(
          duration: scaleDuration ?? const Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: child,
        ),
      ),
    );
  }
}
