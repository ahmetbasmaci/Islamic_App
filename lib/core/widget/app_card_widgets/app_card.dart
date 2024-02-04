import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.useMargin,
    required this.child,
    this.decoration,
  });
  final bool useMargin;
  final Widget child;
  final Decoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: useMargin ? EdgeInsets.only(bottom: AppSizes.spaceBetweanWidgets) : null,
      decoration: decoration ?? AppDecorations.zikrCard(context),
      child: child,
    );
  }
}
