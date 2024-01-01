import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'resources.dart';

class AppDecorations {
  static BoxDecoration quranTopCard(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: .5,
          offset: const Offset(0, 3),
        ),
        BoxShadow(
          color: context.themeColors.primary.withOpacity(.1),
          blurRadius: 10,
          offset: const Offset(0, 3),
        )
      ],
    );
  }

  static BoxDecoration quranBottmCard(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: .5,
          offset: const Offset(0, -3),
        ),
        BoxShadow(
          color: context.themeColors.primary.withOpacity(.1),
          blurRadius: 10,
          offset: const Offset(0, -3),
        )
      ],
    );
  }

  static BoxDecoration suggesstionCard(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 0),
          color: context.themeColors.primary.withOpacity(1),
          blurRadius: 5,
          spreadRadius: 2,
          blurStyle: BlurStyle.outer,
        )
      ],
    );
  }

  static BoxDecoration cardWithPrimery(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: BorderRadius.all(Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          color: context.themeColors.primary.withOpacity(0.8),
          blurRadius: .8,
          spreadRadius: .2,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  static BoxDecoration zikrCard(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: BorderRadius.all(Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: .5,
        )
      ],
    );
  }

  static BoxDecoration zikrCardAfterTappingEnd(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: BorderRadius.all(Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: .5,
        ),
        BoxShadow(
          color: context.themeColors.succes.withOpacity(1),
          blurRadius: 1,
          spreadRadius: 1,
        )
      ],
    );
  }
}
