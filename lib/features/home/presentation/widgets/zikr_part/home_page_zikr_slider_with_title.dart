import 'package:flutter/material.dart';
import 'home_page_zikr_category_card.dart';
import '../../../../../core/utils/resources/app_sizes.dart';
import '../../../../../core/utils/resources/app_styles.dart';
import '../../../../azkar/data/models/zikr_category_model.dart';

class HomePageZikrSliderWithTitle extends StatelessWidget {
  const HomePageZikrSliderWithTitle({super.key, required this.title, required this.zikrCategoryModels});
  final String title;
  final List<ZikrCategoryModel> zikrCategoryModels;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(context),
          _cardSlider(),
        ],
      ),
    );
  }

  SizedBox _cardSlider() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        // shrinkWrap: true,
        physics: zikrCategoryModels.length > 2
            ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
            : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: zikrCategoryModels.length,
        itemBuilder: (context, index) {
          ZikrCategoryModel zikrCategoryModel = zikrCategoryModels[index];
          return HomePageZikrCategoryCard(
            context: context,
            zikrCategoryModel: zikrCategoryModel,
          );
        },
      ),
    );
  }

  Text _title(BuildContext context) => Text(title, style: AppStyles.title(context));
}
