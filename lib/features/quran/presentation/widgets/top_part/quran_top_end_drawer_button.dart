import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/constants.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranTopEndDrawerButton extends StatelessWidget {
  const QuranTopEndDrawerButton({super.key});
  @override
  Widget build(BuildContext context) {
    return QuranAppbarButton(
      child: IconButton(
        onPressed: () => Constants.scaffoldKey.currentState!.openEndDrawer(),
        icon: AppIcons.book,
      ),
    );
  }
}
