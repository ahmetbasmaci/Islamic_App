import 'package:flutter/material.dart';
import 'app_card.dart';

import '../../utils/resources/resources.dart';

class AppCardWithTitle extends StatelessWidget {
  const AppCardWithTitle({
    super.key,
    required this.outsideTitle,
    required this.child,
  });
  final String outsideTitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSizes.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(context),
          AppCard(
            useMargin: false,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      outsideTitle,
      style: AppStyles.title(context),
    );
  }
}
