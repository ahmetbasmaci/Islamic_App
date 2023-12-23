import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/features/pray_times/pray_times.dart';

import '../../../../core/utils/resources/resources.dart';

class PrayTimeLeftCard extends StatelessWidget {
  PrayTimeLeftCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.spaceBetweanParts),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
          BoxShadow(
            color: context.primaryColor,
            blurRadius: 6,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      width: context.width * .55,
      height: context.height * .25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            context.read<PrayTimesCubit>().nextPrayModel.prayTimeType.translatedName,
            style: AppStyles.title2(context),
          ),
          Text(
            context.read<PrayTimesCubit>().state.timeLeftToNextPrayTime,
            style: AppStyles.title(context),
          ),
        ],
      ),
    );
  }
}
