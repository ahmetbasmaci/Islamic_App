import 'package:flutter/material.dart';

class NextPrevDaysArrows extends StatelessWidget {
  const NextPrevDaysArrows({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            // await prayerTimeCtr.updatePrayerTimes(newTime: prayerTimeCtr.curerntDate.value.add(Duration(days: 1)));

            // setState(() {});
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        IconButton(
          onPressed: () async {
            // await prayerTimeCtr.updatePrayerTimes(newTime: prayerTimeCtr.curerntDate.value.subtract(Duration(days: 1)));
            // setState(() {});
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
