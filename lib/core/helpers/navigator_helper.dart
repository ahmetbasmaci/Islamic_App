import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_router.dart';
import '../utils/constants.dart';

class NavigatorHelper {
  static Future<void> pushNamed(
    Routes route, {
    Map<String, String>? arguments,
    Object? extra,
  }) async {
    // if (Constants.scaffoldKey.currentState!.isDrawerOpen) {
    //   Constants.scaffoldKey.currentState!.closeDrawer();
    // }
    await Constants.context.pushNamed(
      route.name,
      pathParameters: arguments ?? {},
      extra: extra,
    );
  }

  static Future<void> pushReplacementNamed(
    Routes route, {
    Map<String, String>? arguments,
    Object? extra,
  }) async {
    Constants.context.goNamed(
      route.name,
      pathParameters: arguments ?? {},
      extra: extra,
    );
  }

  static pop() {
    //this is to make sure that the context is not null
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Constants.context.pop();
    });
  }
}
