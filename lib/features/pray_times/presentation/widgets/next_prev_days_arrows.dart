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
        IconButton(
          onPressed: () async => await context.read<PrayTimesCubit>().updateNextdayPrayerTimes(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        IconButton(
          onPressed: () async => await context.read<PrayTimesCubit>().updatePreviosdayPrayerTimes(),
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
