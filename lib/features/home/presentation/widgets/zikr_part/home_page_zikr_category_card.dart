import 'package:flutter/material.dart';
import '../../../../../core/extentions/extentions.dart';
import '../../../../../core/helpers/navigator_helper.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../../../core/widget/app_card_widgets/app_card_widgets.dart';
import '../../../../azkar/data/models/zikr_category_model.dart';

class HomePageZikrCategoryCard extends StatelessWidget {
  const HomePageZikrCategoryCard({super.key, required this.context, required this.zikrCategoryModel});
  final BuildContext context;
  final ZikrCategoryModel zikrCategoryModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: AppCardDecoration(color_: context.backgroundColor),
      margin: EdgeInsets.only(
        right: AppSizes.cardPadding,
        top: AppSizes.cardPadding,
        bottom: AppSizes.cardPadding,
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              zikrCategoryModel.title,
              style: AppStyles.title2(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  zikrCategoryModel.imagePath,
                  width: AppSizes.imagezikrCard,
                ),
                AppIcons.rightArrow
              ],
            ),
          ],
        ),
        onTap: () {
          NavigatorHelper.pushNamed(
            Routes.azkar,
            extra: zikrCategoryModel,
          );
        },
      ),
    );
  }
}
