// ignore_for_file: must_be_immutable, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zad_almumin/constents/my_sizes.dart';

import '../constents/my_colors.dart';

class MyIndicator extends StatelessWidget {
  MyIndicator({Key? key, this.color, this.backgroundColor, this.size = 5}) : super(key: key);
  Color? color;
  Color? backgroundColor;
  double? size;

  @override
  Widget build(BuildContext context) {
    if (size == 0) return Container();
    var spinkit = Center(
      child: SpinKitWaveSpinner(
        color: color ?? MyColors.primary,
        size: size ?? 50,
        waveColor: backgroundColor ?? MyColors.second.withOpacity(.5),
      ),
    );

    return spinkit;
  }
}

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
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
