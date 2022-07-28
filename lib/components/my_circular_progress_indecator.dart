import 'package:flutter/material.dart';
import 'package:zad_almumin/constents/sizes.dart';

import '../constents/colors.dart';

class MyCircularProgressIndecator extends StatelessWidget {
  const MyCircularProgressIndecator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: MySiezes.circularProgressIndecator,
      height: MySiezes.circularProgressIndecator,
      child: CircularProgressIndicator(
        color: MyColors.primary,
        strokeWidth: 2,
        backgroundColor: MyColors.background(),
      ),
    ));
  }
}
