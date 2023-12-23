import 'package:flutter/material.dart';

class TransitionFromTop50 extends StatelessWidget {
  const TransitionFromTop50({super.key, required this.child, this.duration, this.transformTween});
  final Widget child;
  final Duration? duration;
  final Tween<Offset>? transformTween;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: transformTween ?? Tween(begin: const Offset(0, -100), end: const Offset(0, 0)),
      duration: duration ?? const Duration(milliseconds: 300),
      builder: (context, Offset tween, child) => Transform.translate(offset: tween, child: child),
      child: child,
    );
  }
}
