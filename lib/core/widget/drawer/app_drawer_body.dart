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
              route: Routes.home,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).quran,
              icon: AppIcons.quran,
              route: Routes.home, //TODO
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).alarm,
              icon: AppIcons.alarmOn,
              route: Routes.alarm, //TODO
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).prayTimes,
              icon: AppIcons.prayersTime,
              route: Routes.prayTimes,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).quranRevidion,
              icon: AppIcons.ayahsTest,
              route: Routes.home, //TODO
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).muslimZikrs,
              icon: AppIcons.azkar,
              route: Routes.allAzkars,
            ),
            const Divider(height: 50, thickness: 2),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).favorite,
              icon: AppIcons.favoriteFilled,
              route: Routes.home, //TODO
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).settings,
              icon: AppIcons.settings,
              route: Routes.settings,
            ),
            AppDrawerItem(
              context: context,
              title: AppStrings.of(context).appDeveloper,
              icon: AppIcons.review,
              route: Routes.home, //TODO
            ),
          ],
        ),
      ),
    );
  }
}
