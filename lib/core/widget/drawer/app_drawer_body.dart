import 'package:flutter/material.dart';
import 'app_drawer_item.dart';

import '../../../config/local/l10n.dart';
import '../../utils/resources/app_icons.dart';
import '../../utils/app_router.dart';

class AppDrawerBody extends StatelessWidget {
  const AppDrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).home,
              icon: AppIcons.home,
              route: AppRoutes.home,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).quran,
              icon: AppIcons.quran,
              route: AppRoutes.quran,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).alarm,
              icon: AppIcons.alarmOn,
              route: AppRoutes.alarm,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).prayTimes,
              icon: AppIcons.prayersTime,
              route: AppRoutes.prayTimes,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).quranRevidion,
              icon: AppIcons.ayahsTest,
              route: AppRoutes.quranQuestions,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).muslimZikrs,
              icon: AppIcons.azkar,
              route: AppRoutes.allAzkars,
            ),
            const Divider(height: 50, thickness: 2),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).favorite,
              icon: AppIcons.favoriteFilled,
              route: AppRoutes.home, //TODO
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).settings,
              icon: AppIcons.settings,
              route: AppRoutes.settings,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).appDeveloper,
              icon: AppIcons.review,
              route: AppRoutes.home, //TODO
            ),
          ],
        ),
      ),
    );
  }
}
