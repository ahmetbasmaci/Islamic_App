import 'package:flutter/material.dart';
import '../../azkar.dart';

import '../../../../core/helpers/navigator_helper.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../../../core/widget/animations/animated_list_item_up_to_down.dart';

class ZikrListTileItem extends StatelessWidget {
  const ZikrListTileItem({
    super.key,
    required this.index,
    required this.zikrCategoryModel,
  });
  final int index;
  final ZikrCategoryModel zikrCategoryModel;
  @override
  Widget build(BuildContext context) {
    return AnimatedListItemUpToDown(
      index: index,
      child: Card(
        child: ListTile(
          title: Text(
            zikrCategoryModel.title,
            style: AppStyles.title2(context),
          ),
          leading: Image.asset(zikrCategoryModel.imagePath),
          trailing: AppIcons.rightArrow,
          onTap: () {
            NavigatorHelper.pushNamed(
              AppRoutes.azkar,
              extra: zikrCategoryModel,
            );
          },
        ),
      ),
    );
  }
}
