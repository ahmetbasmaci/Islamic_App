import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranTopSearchButton extends StatelessWidget {
  const QuranTopSearchButton({super.key});
  //TODO imoplemnt search
  @override
  Widget build(BuildContext context) {
    return QuranAppbarButton(
      child: IconButton(
        onPressed: () {},
        icon: AppIcons.search,
      ),
    );
  }
  //=> showSearch(context: context, delegate: QuranSearchDelegate()),
}
