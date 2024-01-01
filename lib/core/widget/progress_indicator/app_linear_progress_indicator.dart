import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

class AppLinearProgressIndicator extends StatelessWidget {
  final double? value;
  const AppLinearProgressIndicator({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: Colors.grey,
        color: context.themeColors.primary,
      ),
    );
  }
}
