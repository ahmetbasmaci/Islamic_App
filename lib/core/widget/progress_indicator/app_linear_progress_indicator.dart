import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

class AppLinearProgressIndicator extends StatelessWidget {
  final double? value;
  const AppLinearProgressIndicator({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    print(value);
    return Center(
      child: LinearProgressIndicator(
        value: value ?? 0,
        valueColor: AlwaysStoppedAnimation<Color>(context.themeColors.primary),
        backgroundColor: Colors.grey.withOpacity(.1),
      ),
    );
  }
}
