import 'package:flutter/material.dart';

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
