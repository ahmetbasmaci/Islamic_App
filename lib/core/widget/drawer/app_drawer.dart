import 'package:flutter/material.dart';
import '../../extentions/extentions.dart';
import '../../utils/resources/app_sizes.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'app_drawer_body.dart';

import 'app_drawer_header.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: context.isArabicLang ? OvalLeftBorderClipper() : OvalRightBorderClipper(),
      child: Drawer(
        width: AppSizes.drawerWith,
        child: const Column(
          children: [
            AppDrawerHeader(),
            AppDrawerBody(),
          ],
        ),
      ),
    );
  }
}
