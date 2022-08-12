import 'package:flutter/material.dart';
import '../constents/sizes.dart';

Widget mainContainer({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
    child: child,
  );
}

class HelperComponents {}
