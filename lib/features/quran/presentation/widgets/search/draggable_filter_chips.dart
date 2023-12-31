import 'package:flutter/material.dart';

import '../../../quran.dart';

class DraggableFilterChips extends StatelessWidget {
  const DraggableFilterChips({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuranSeachDragTargetChipWidget(index: 0),
            QuranSeachDragTargetChipWidget(index: 1),
            QuranSeachDragTargetChipWidget(index: 2),
          ],
        ),
        // Divider(),
      ],
    );
  }
}
