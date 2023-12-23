import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedListItemDownToUp extends StatelessWidget {
  const AnimatedListItemDownToUp({
    super.key,
    required this.index,
    required this.child,
    this.staggerDuration,
    this.slideDuration,
    this.flipDuration,
  });
  final int index;
  final Widget child;
  final Duration? staggerDuration;
  final Duration? slideDuration;
  final Duration? flipDuration;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: staggerDuration ?? const Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: slideDuration ?? const Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
        horizontalOffset: 30,
        verticalOffset: 300.0,
        child: FlipAnimation(
          duration: flipDuration ?? const Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
          flipAxis: FlipAxis.y,
          child: child,
        ),
      ),
    );
  }
}
