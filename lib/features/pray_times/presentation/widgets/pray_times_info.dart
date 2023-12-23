import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/space/vertical_space.dart';
import 'package:zad_almumin/features/pray_times/presentation/cubit/pray_times_cubit.dart';

import '../../../../core/utils/enums/enums.dart';

class PrayTimesInfo extends StatelessWidget {
  PrayTimesInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(AppStrings.of(context).gregorianDate),
                  Text(context.read<PrayTimesCubit>().state.currentDayPrayDetailesModel.gregorianDate),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(AppStrings.of(context).hijriDate),
                  Text(context.read<PrayTimesCubit>().state.currentDayPrayDetailesModel.hijriDate),
                ],
              ),
            ],
          ),
          const Divider(thickness: 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const VerticalSpace(AppSizes.spaceBetweanParts),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  prayerTimeCard(context, PrayTimeType.fajr),
                  prayerTimeCard(context, PrayTimeType.sun),
                  prayerTimeCard(context, PrayTimeType.duhr),
                ],
              ),
              const VerticalSpace(AppSizes.spaceBetweanParts),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  prayerTimeCard(context, PrayTimeType.asr),
                  prayerTimeCard(context, PrayTimeType.maghrib),
                  prayerTimeCard(context, PrayTimeType.isha),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget prayerTimeCard(BuildContext context, PrayTimeType prayerTimeType) {
    PrayTimesCubit prayerTimeCubit = context.read<PrayTimesCubit>();
    String title = prayerTimeType.translatedName;
    String time = prayerTimeCubit.getPrayTimeByType(prayerTimeType);
    // time = '${prayerTimeCtr.fajrTime.value.hour}:${prayerTimeCtr.fajrTime.value.minute}';

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration:
            prayerTimeType == prayerTimeCubit.nextPrayModel.prayTimeType //check if the prayer is the next prayer
                //&& prayerTimeCubit.currentDayPrayDetailesModel..day == DateTime.now().day //check if today
                ? BoxDecoration(
                    color: context.backgroundColor,
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                    boxShadow: [
                      BoxShadow(color: context.primaryColor, blurRadius: 10, offset: const Offset(0, 3)),
                    ],
                  )
                : const BoxDecoration(),
        child: Column(
          children: [
            Text(title),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: Text(time),
            ),
          ],
        ),
      ),
    );
  }
}
