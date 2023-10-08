// ignore_for_file: must_be_immutable, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zad_almumin/constents/my_sizes.dart';

import '../constents/my_colors.dart';

class MyIndicator extends StatelessWidget {
  MyIndicator({Key? key, this.color, this.backgroundColor}) : super(key: key);
  Color? color = MyColors.primary;
  Color? backgroundColor = MyColors.background;

  var spinkit = SpinKitWaveSpinner(
    color: MyColors.primary,
    size: 50.0,
    waveColor: MyColors.second.withOpacity(.5),
  );

  @override
  Widget build(BuildContext context) {
    return spinkit;
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
