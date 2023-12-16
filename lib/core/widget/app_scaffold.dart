import 'package:flutter/material.dart';
import 'app_appbar.dart';

import 'drawer/app_drawer.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.leading,
    this.actions,
    this.floatingActionButton,
    this.showSettingsBtn = false,
    this.showDrawerBtn = true,
    this.centerTitle = false,
    this.resizeToAvoidBottomInset = false,
  });
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showSettingsBtn;
  final bool showDrawerBtn;
  final bool centerTitle;
  final Widget body;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppAppBar(
        title: title,
        leading: leading,
        actions: actions,
        showSettingsBtn: showSettingsBtn,
        showDrawerBtn: showDrawerBtn,
        centerTitle: centerTitle,
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
