import 'package:flutter/material.dart';
import '../helpers/navigator_helper.dart';
import '../utils/app_router.dart';
import '../utils/resources/app_icons.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  AppAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    // this.bottom,
    this.showSettingsBtn = false,
    this.showDrawerBtn = false,
    this.centerTitle = false,
  });
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  bool showSettingsBtn;
  bool showDrawerBtn;
  bool centerTitle;
  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title),
      centerTitle: centerTitle,
      leading: _getLeading(context),
      actions: _getActions(context),

      // bottom: bottom,
    );
  }

  Widget? _getLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showDrawerBtn) return _drawerButton(context);

    return Container();
  }

  List<Widget>? _getActions(BuildContext context) {
    List<Widget> actions = [];

    actions.addAll(this.actions ?? []);

    if (showSettingsBtn) actions.add(_settingsPageButton(context));

    actions.add(_backButton(context));

    return actions;
  }

  IconButton _drawerButton(BuildContext context) {
    return IconButton(
      icon: AppIcons.drawer,
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }

  IconButton _settingsPageButton(BuildContext context) {
    return IconButton(
      icon: AppIcons.settings,
      onPressed: () => NavigatorHelper.pushNamed(AppRoutes.settings),
    );
  }

  Widget _backButton(BuildContext context) {
    return !ModalRoute.of(context)!.isFirst
        ? IconButton(
            onPressed: () => NavigatorHelper.pop(),
            icon: AppIcons.backArrow,
          )
        : Container();
  }
}
