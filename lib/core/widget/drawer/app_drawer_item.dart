import 'package:flutter/material.dart';
import '../../extentions/extentions.dart';

import '../../helpers/navigator_helper.dart';
import '../../utils/app_router.dart';

class AppDrawerItem extends StatelessWidget {
  AppDrawerItem({
    super.key,
    required this.context,
    required this.title,
    required this.icon,
    required this.route,
  });
  final BuildContext context;
  final String title;
  final Widget icon;
  final Routes route;

  @override
  Widget build(BuildContext context) {
    bool selected = context.currentRoute!.contains(route.name);
    bool isHomePage = context.currentRoute!.contains(Routes.home.name);
    return ListTile(
      leading: icon,
      title: Text(title),
      selected: selected,
      onTap: () async {
        if (selected)
          NavigatorHelper.pop();
        else if (isHomePage)
          await NavigatorHelper.pushNamed(route);
        else
          await NavigatorHelper.pushReplacementNamed(route);

        NavigatorHelper.pop();
      },
    );
  }
}
