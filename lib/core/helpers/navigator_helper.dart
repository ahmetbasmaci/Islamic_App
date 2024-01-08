import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_router.dart';
import '../utils/resources/app_constants.dart';

class NavigatorHelper {
  NavigatorHelper._();
  static Future<void> pushNamed(
    AppRoutes route, {
    Map<String, String>? arguments,
    Object? extra,
  }) async {
    await AppConstants.context.pushNamed(
      route.name,
      pathParameters: arguments ?? {},
      extra: extra,
    );
  }

  static Future<void> pushReplacementNamed(
    AppRoutes route, {
    Map<String, String>? arguments,
    Object? extra,
  }) async {
    AppConstants.context.goNamed(
      route.name,
      pathParameters: arguments ?? {},
      extra: extra,
    );
  }

  static pop() {
    //this is to make sure that the context is not null
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppConstants.context.pop();
    });
  }
}
