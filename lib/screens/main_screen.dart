import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/zikr_card/zikr_cards.dart';
import 'package:zad_almumin/constents/assets_manager.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/pages/azkar/azkar_page.dart';
import 'package:zad_almumin/services/animation_service.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../classes/block_data.dart';
import '../constents/app_settings.dart';

class MainScreen extends GetView<ThemeCtr> {
  MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.theme;
    return AnimationLimiter(
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          AnimationService.animationListItemDownToUp(index: 1, child: ZikrCard().quranCard()),
          AnimationService.animationListItemDownToUp(index: 2, child: ZikrCard().hadithCard()),
          AnimationService.animationListItemDownToUp(
            index: 3,
            child: azkarBlocks(
              outsideTitle: 'مختلف الأذكار'.tr,
              azkars: BlockData.list,
              zikrType: ZikrType.azkar,
            ),
          ),
          AnimationService.animationListItemDownToUp(
            index: 4,
            child: azkarBlocks(
              outsideTitle: 'أسماء الله الحسنى'.tr,
              azkars: [BlockData(imageSource: ImagesManager.quran, title: 'تعرّف على اسماء الله الحسنى'.tr)],
              zikrType: ZikrType.allahNames,
            ),
          ),
        ],
      ),
    );
  }

  azkarBlocks({required String outsideTitle, required List<BlockData> azkars, required ZikrType zikrType}) {
    Widget childs = Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTexts.outsideHeader(title: outsideTitle, color: MyColors.primary),
              // TextButton(
              //   style: azkars.length > 1
              //       ? ButtonStyle(
              //           overlayColor: MaterialStateProperty.all(MyColors.primary.withOpacity(.2)),
              //           elevation: MaterialStateProperty.all(1),
              //           backgroundColor: MaterialStateProperty.all(MyColors.background),
              //         )
              //       : null,
              //   onPressed: azkars.length > 1 ? () => Get.to(() => AzkarBlockScreen(), curve: Curves.elasticIn) : null,
              //   child: azkars.length > 1
              //       ? MyTexts.outsideHeader(title: 'الكل'.tr, color: MyColors.primary)
              //       : Container(),
              // ),
            ],
          ),
          const SizedBox(height: MySiezes.betweanAzkarBlock),
          Align(
            alignment: AppSettings.isArabicLang ? Alignment.centerRight : Alignment.centerLeft,
            child: SizedBox(
              height: MySiezes.heightOfAzkarBlock * 1.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: azkars.length,
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(MySiezes.blockRadius),
                        // color: MyColors.zikrCard,
                        color: MyColors.zikrCard,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.5),
                            blurRadius: 3,
                            // offset: Offset(-2, 0),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(
                        // left: index != azkars.length - 1 ? MySiezes.betweanAzkarBlock : 0,
                        left: MySiezes.betweanAzkarBlock,
                        right: index == 0 ? MySiezes.betweanAzkarBlock : 0,
                        top: MySiezes.betweanAzkarBlock,
                        bottom: MySiezes.betweanAzkarBlock,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          MyTexts.blockTitle(title: azkars[index].title.tr, color: MyColors.primary),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Image.asset(
                                azkars[index].imageSource,
                                width: MySiezes.image * .8,
                              ),
                              MyIcons.leftArrow()
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.to(
                        () => AzkarPage(zikrIndexInJson: index, zikrType: zikrType),
                        transition: Transition.size,
                        duration: Duration(milliseconds: 500),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
    return childs;
  }
}
