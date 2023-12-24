import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/features/pray_times/presentation/cubit/pray_times_cubit.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/widget/app_card_widgets/app_card_widgets.dart';

class PrayTimesInfo extends StatelessWidget {
  PrayTimesInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
      child: Column(
        children: <Widget>[
          _datesAndDayName(context),
          const Divider(thickness: 2),
          _prayerTimesCards(context),
        ],
      ),
    );
  }

  Row _datesAndDayName(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _dateTitle(
          dateTitle: AppStrings.of(context).gregorianDate,
          date: context.read<PrayTimesCubit>().state.currentDayPrayDetailesModel.gregorianDate,
        ),
        Text(context.read<PrayTimesCubit>().state.currentDayPrayDetailesModel.dayName.translatedName),
        _dateTitle(
          dateTitle: AppStrings.of(context).hijriDate,
          date: context.read<PrayTimesCubit>().state.currentDayPrayDetailesModel.hijriDate,
        ),
      ],
    );
  }

  Column _dateTitle({required String dateTitle, required String date}) {
    return Column(
      children: <Widget>[
        Text(dateTitle),
        Text(date),
      ],
    );
  }

  Widget _prayerTimesCards(BuildContext context) {
    return SizedBox(
      height: context.height * 0.3,
      width: context.width,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          crossAxisSpacing: AppSizes.cardPadding,
          mainAxisSpacing: AppSizes.cardPadding,
        ),
        children: <Widget>[
          prayerTimeCard(context, PrayTimeType.fajr),
          prayerTimeCard(context, PrayTimeType.sun),
          prayerTimeCard(context, PrayTimeType.duhr),
          prayerTimeCard(context, PrayTimeType.asr),
          prayerTimeCard(context, PrayTimeType.maghrib),
          prayerTimeCard(context, PrayTimeType.isha),
        ],
      ),
    );
  }

  Widget prayerTimeCard(BuildContext context, PrayTimeType prayerTimeType) {
    PrayTimesCubit prayerTimeCubit = context.read<PrayTimesCubit>();
    String title = prayerTimeType.translatedName;
    String time = prayerTimeCubit.getPrayTimeByType(prayerTimeType);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.cardPadding),
      decoration: _prayCardDecoration(prayerTimeType, prayerTimeCubit, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: AppStyles.content(context).copyWith(fontWeight: FontWeight.bold),
          ),
          Text(time),
        ],
      ),
    );
  }

  BoxDecoration _prayCardDecoration(PrayTimeType prayerTimeType, PrayTimesCubit prayerTimeCubit, BuildContext context) {
    bool isTodayPrayTime = prayerTimeCubit.currentPageDate.day == DateTime.now().day;
    bool isNextPrayTime = prayerTimeType == prayerTimeCubit.nextPrayModel.prayTimeType;
    return isTodayPrayTime && isNextPrayTime ? AppCardDecoration.withPrimery() : const BoxDecoration();
  }
}
