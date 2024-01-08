import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';

class NoTafseersForCurrentLocalWidget extends StatelessWidget {
  const NoTafseersForCurrentLocalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            AppIcons.warning.icon,
            size: context.width * 0.6,
          ),
          Text(
            'لا يوجد تفاسير للغة المحددة حاليا ستتم إضافة التفاسير لاحقا ان شاء الله',
            style: AppStyles.title,
            textAlign: TextAlign.center,
          ),
          AppGifs.sadFace,
        ],
      ),
    );
  }
}
