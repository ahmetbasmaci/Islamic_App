import 'package:flutter/material.dart';
import '../../utils/resources/app_sizes.dart';
import '../space/space.dart';

class AppCardContent extends StatelessWidget {
  AppCardContent({
    required this.topPartWidget,
    required this.centerPartWidget,
    required this.footerPartWidget,
  });
  Widget topPartWidget;
  Widget centerPartWidget;
  Widget footerPartWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.cardPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          topPartWidget,
          VerticalSpace(AppSizes.cardPadding),
          centerPartWidget,
          VerticalSpace(AppSizes.cardPadding),
          footerPartWidget,
        ],
      ),
    );
  }
}
