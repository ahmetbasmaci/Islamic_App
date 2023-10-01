// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:zad_almumin/constents/my_sizes.dart';

import '../constents/my_colors.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  MyCircularProgressIndicator({Key? key, this.color, this.backgroundColor}) : super(key: key);
  Color? color = MyColors.primary;
  Color? backgroundColor = MyColors.background;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MySiezes.circularProgressIndecator,
      height: MySiezes.circularProgressIndecator,
      child: Center(
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 2,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
