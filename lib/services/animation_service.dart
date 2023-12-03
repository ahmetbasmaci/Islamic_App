import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimationService {
  static Widget animationListItemUpToDown({required int index, required Widget child}) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
        verticalOffset: -250,
        child: ScaleAnimation(
          duration: Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: child,
        ),
      ),
    );
  }

  static Widget animationListItemDownToUp({required int index, required Widget child}) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
        horizontalOffset: 30,
        verticalOffset: 300.0,
        child: FlipAnimation(
          duration: Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
          flipAxis: FlipAxis.y,
          child: child,
        ),
      ),
    );
  }

  static Widget transformFromTop50({required Widget child, Tween<Offset>? transformTween}) {
    transformTween = Tween(begin: Offset(0, -100), end: Offset(0, 0));
    return TweenAnimationBuilder(
      tween: transformTween,
      duration: Duration(milliseconds: 300),
      builder: (context, Offset tween, child) => Transform.translate(offset: tween, child: child),
      child: child,
    );
  }

  static Widget transformRightToLeft({required Widget child, Tween<Offset>? transformTween, Duration? duration}) {
    transformTween = transformTween ?? Tween(begin: Offset(1500, 0), end: Offset(0, 0));
    return TweenAnimationBuilder(
      tween: transformTween,
      duration: duration ?? Duration(milliseconds: 300),
      builder: (context, Offset tween, child) => Transform.translate(offset: tween, child: child),
      child: child,
    );
  }

  static Widget fadeOut({required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 150),
      builder: (context, double tween, child) => Transform.scale(scale: tween, child: child),
      child: child,
    );
  }

  static Widget animatedSwicherTransition({required Duration duration}) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
    );
  }
}

class AnimatedButtonTapping extends StatefulWidget {
  const AnimatedButtonTapping({required this.child, required this.onTap, required this.onTapUp});
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onTapUp;

  @override
  _AnimatedButtonTappingState createState() => _AnimatedButtonTappingState();
}

class _AnimatedButtonTappingState extends State<AnimatedButtonTapping> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      _controller.forward();
      widget.onTap!.call();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onTapUp != null) {
      _controller.reverse();
      widget.onTapUp!.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return Center(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Transform.scale(
          scale: _scale,
          child: _animatedButtonUI,
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => widget.child;
}
