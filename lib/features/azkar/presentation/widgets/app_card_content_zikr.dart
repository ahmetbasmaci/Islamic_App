import 'package:flutter/material.dart';
import '../../../../config/local/l10n.dart';
import '../../../../core/extentions/extentions.dart';
import '../../../../core/utils/resources/app_sizes.dart';
import '../../../../core/utils/resources/app_styles.dart';
import '../../azkar.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../../../core/widget/animations/animated_list_item_down_to_up.dart';
import '../../../../core/widget/app_card_widgets/app_card_widgets.dart';

class AppCardContentZikr extends StatelessWidget {
  AppCardContentZikr({
    super.key,
    this.zikrModel,
    this.allahNamesModel,
    required this.currentIndex,
    required this.zikrCategoty,
  });
  final ZikrCardModel? zikrModel;
  final AllahNamesModel? allahNamesModel;
  final int currentIndex;
  final ZikrCategories zikrCategoty;
  int totalIndex = 0;
  @override
  Widget build(BuildContext context) {
    totalIndex = 0;
    return zikrCategoty == ZikrCategories.allahNames ? _allahNamesBody(context) : _azkarsBody(context);
  }

  Widget _allahNamesBody(BuildContext context) {
    return _appCardContent(
      context: context,
      useMargin: true,
      title: allahNamesModel!.name,
      content: allahNamesModel!.content,
      description: '',
      count: -1,
    );
  }

  Widget _azkarsBody(BuildContext context) {
    if (zikrModel!.haveList) {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: zikrModel!.list.length,
          itemBuilder: (context, index2) {
            if (index2 > 0) {
              zikrModel!.title = "${zikrModel!.title} ${index2 + 1}";
            }
            zikrModel!.content = zikrModel!.list[index2]['zekr'] ?? "";
            return _appCardContent(
              context: context,
              useMargin: false,
              title: zikrModel!.title,
              content: '${zikrModel!.content}\n${zikrModel!.description}',
              description: zikrModel!.description,
              count: zikrModel!.count,
            );
          });
    } else {
      return _appCardContent(
        context: context,
        useMargin: true,
        title: zikrModel!.title,
        content: '${zikrModel!.content}\n${zikrModel!.description}',
        description: zikrModel!.description,
        count: zikrModel!.count,
      );
    }
  }

  Widget _appCardContent({
    required BuildContext context,
    required bool useMargin,
    required String title,
    required String content,
    required String description,
    required int count,
  }) {
    totalIndex++;
    return AnimatedListItemDownToUp(
      index: totalIndex,
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AppCardWithTappingAnimation(
            onTap: count > 0 ? () {} : null,
            onTapUp: count > 0
                ? () async {
                    count--;
                    try {
                      setState(() {});
                    } catch (e) {
                      print("ERROR IN ZIKR CARD: $e");
                    }
                  }
                : null,
            boxShadow: _cardCountDecoration(context, count),
            useMargin: useMargin,
            child: AppCardContent(
              topPartWidget: _topPartWidget(context, title, count),
              centerPartWidget: _centerPartWidget(content, description),
              footerPartWidget: _footerPartWidget(context, title, content, count),
            ),
          );
        },
      ),
    );
  }

  BoxShadow? _cardCountDecoration(BuildContext context, int count) {
    return count > 0 || count == -1
        ? null
        : BoxShadow(
            offset: Offset(0, 0),
            color: context.primaryColor.withOpacity(1),
            blurRadius: 5,
            spreadRadius: 2,
            blurStyle: BlurStyle.outer,
          );
  }

  Widget _topPartWidget(BuildContext context, String title, int count) {
    return AppCardTopPart(
      centerWidget: Text(
        title,
        style: AppStyles.title2(context).copyWith(color: context.primaryColor),
      ),
    );
  }

  Widget _centerPartWidget(String content, String description) {
    return Column(
      children: <Widget>[
        AppCardCenterPartWidget(
          content: content,
          description: description,
        ),
      ],
    );
  }

  Widget _footerPartWidget(BuildContext context, String title, String content, int count) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.cardPadding * 2),
      child: Column(
        children: [
          AppCardContentFooterPartButtons(isFavorite: false, content: content),
          count > 0 ? _counterWidget(context, count) : Container(),
        ],
      ),
    );
  }

  Widget _counterWidget(BuildContext context, int count) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: context.primaryColor.withOpacity(.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Text(
        count != 0 ? "$count" : AppStrings.of(context).done,
        style: AppStyles.title2(context),
        textAlign: TextAlign.center,
      ),
    );
  }
}
