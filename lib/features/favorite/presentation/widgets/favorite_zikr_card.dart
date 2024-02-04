import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../core/utils/resources/resources.dart';
import '../../../../core/widget/app_card_widgets/app_card_widgets.dart';

class FavoriteZikrCard extends StatelessWidget {
  const FavoriteZikrCard({
    super.key,
    required this.title,
    required this.content,
    this.description = '',
  });
  final String title;
  final String content;
  final String description;
  @override
  Widget build(BuildContext context) {
    return AppCard(
      useMargin: true,
      child: AppCardContent(
        topPartWidget: _topPartWidget(context, title),
        centerPartWidget: _centerPartWidget(content, description),
        footerPartWidget: _footerPartWidget(context, title, content),
      ),
    );
  }

  Widget _topPartWidget(BuildContext context, String title) {
    return AppCardTopPart(
      centerWidget: Text(
        title,
        style: AppStyles.title2.copyWith(color: context.themeColors.primary),
      ),
    );
  }

  Widget _centerPartWidget(String content, String description) {
    return AppCardCenterPartWidget(
      content: content,
      description: description,
    );
  }

  Widget _footerPartWidget(BuildContext context, String title, String content) {
    return AppCardContentFooterPartButtons(isFavorite: true, content: content);
  }
}
