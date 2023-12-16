import 'package:flutter/material.dart';
import '../../extentions/extentions.dart';
import 'app_card_widgets.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.useMargin,
    required this.child,
    this.boxShadow,
  });
  final bool useMargin;
  final Widget child;
  final BoxShadow? boxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: useMargin ? EdgeInsets.all(10) : null,
      decoration: AppCardDecoration(
        boxShadow_: boxShadow,
        color_: context.backgroundColor,
      ),
      child: child,
    );
  }
}
