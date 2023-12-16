import 'package:flutter/material.dart';

class AppCardTopPart extends StatelessWidget {
  const AppCardTopPart({
    super.key,
    this.startWidget,
    this.centerWidget,
    this.endWidget,
  });

  final Widget? startWidget;
  final Widget? centerWidget;
  final Widget? endWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: startWidget,
        ),
        centerWidget ?? Container(),
        Align(
          alignment: Alignment.topLeft,
          child: endWidget,
        ),
      ],
    );
  }
}
