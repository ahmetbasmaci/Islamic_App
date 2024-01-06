import 'package:flutter/material.dart';
import 'package:zad_almumin/config/local/l10n.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranEndDrawerPagesTitles extends StatelessWidget {
  const QuranEndDrawerPagesTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        QuranEndDrawerPageCategoryHeaderItem(
          title: AppStrings.of(context).pages,
          icon: AppIcons.addBookMark,
          index: 0,
        ),
        QuranEndDrawerPageCategoryHeaderItem(
          title: AppStrings.of(context).ayahs,
          icon: AppIcons.book,
          index: 1,
        ),
      ],
    );
  }
}
