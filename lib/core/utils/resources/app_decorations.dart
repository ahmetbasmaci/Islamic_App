import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import 'resources.dart';

class AppDecorations {
  static BoxDecoration quranTopCard(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          color: context.themeColors.primary.withOpacity(.6),
          blurRadius: 10,
          offset: const Offset(0, 3),
        )
      ],
    );
  }

  static BoxDecoration quranBottmCard(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          color: context.themeColors.primary.withOpacity(.6),
          blurRadius: 10,
          offset: const Offset(0, -3),
        )
      ],
    );
  }
}
