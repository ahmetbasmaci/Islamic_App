import 'package:flutter/material.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(this.width);
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: width);
  }
}
