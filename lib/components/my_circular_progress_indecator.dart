import 'package:flutter/material.dart';
import 'package:zad_almumin/constents/sizes.dart';

import '../constents/colors.dart';

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
