import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranTopEndDrawerButton extends StatelessWidget {
  const QuranTopEndDrawerButton({super.key});
  //TODO imoplemnt endDrawer
  @override
  Widget build(BuildContext context) {
    return QuranAppbarButton(
      child: IconButton(
        onPressed: () => {},
        icon: AppIcons.book,
      ),
    );
  }
  //=> AppSettings.scaffoldKey.currentState!.openEndDrawer(),
}
