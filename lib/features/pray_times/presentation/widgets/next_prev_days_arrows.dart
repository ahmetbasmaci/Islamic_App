import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/features/pray_times/pray_times.dart';

class NextPrevDaysArrows extends StatelessWidget {
  const NextPrevDaysArrows({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _previosDayButton(context),
        _nextDayButton(context),
      ],
    );
  }

  IconButton _nextDayButton(BuildContext context) {
    return IconButton(
      onPressed: () async => await context.read<PrayTimesCubit>().updatePreviosdayPrayerTimes(),
      icon: const Icon(Icons.arrow_forward_ios),
    );
  }

  IconButton _previosDayButton(BuildContext context) {
    return IconButton(
      onPressed: () async => await context.read<PrayTimesCubit>().updateNextdayPrayerTimes(),
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}
