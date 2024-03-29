import 'package:flutter/material.dart';

class TransitionRightToLeft extends StatelessWidget {
  const TransitionRightToLeft({super.key, required this.child, this.duration, this.transformTween});
  final Widget child;
  final Duration? duration;
  final Tween<Offset>? transformTween;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: transformTween ?? Tween(begin: Offset(1500, 0), end: Offset(0, 0)),
      duration: duration ?? Duration(milliseconds: 300),
      builder: (context, Offset tween, child) => Transform.translate(offset: tween, child: child),
      child: child,
    );
  }
}
