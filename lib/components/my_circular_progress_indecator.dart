// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constents/my_colors.dart';

class MyCircularProgressIndecator extends StatelessWidget {
  MyCircularProgressIndecator({Key? key, this.color}) : super(key: key);
  late Color? color;
  @override
  Widget build(BuildContext context) {
    color ??= MyColors.primary();
    return SizedBox(
      // width: MySiezes.circularProgressIndecator,
      // height: MySiezes.circularProgressIndecator,
      child: Center(
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 2,
          backgroundColor: MyColors.background(),
        ),
      ),
    );
  }
}
