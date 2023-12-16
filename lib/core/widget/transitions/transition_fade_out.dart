import 'package:flutter/material.dart';

class TransitionFadeOut extends StatelessWidget {
  const TransitionFadeOut({super.key, required this.child, this.duration});
  final Widget child;
  final Duration? duration;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration ?? Duration(milliseconds: 150),
      builder: (context, double tween, child) => Transform.scale(scale: tween, child: child),
      child: child,
    );
  }
}
