import 'package:flutter/material.dart';

import '../../../../../core/helpers/navigator_helper.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranTopHomeButton extends StatelessWidget {
  const QuranTopHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return QuranAppbarButton(
      child: IconButton(
        onPressed: () => NavigatorHelper.pushReplacementNamed(AppRoutes.home),
        icon: AppIcons.home,
      ),
    );
  }
}
