import 'package:flutter/material.dart';
import '../constents/sizes.dart';

Widget mainContainer({required Widget child}) {
  return Container(
    margin: EdgeInsets.only(
      top: MySiezes.screenPadding,
      left: MySiezes.screenPadding,
      right: MySiezes.screenPadding,
    ),
    height: double.infinity,
    width: double.infinity,
    child: child,
  );
}
