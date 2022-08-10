import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/zikr_cards.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/pages/azkar_page.dart';
import 'package:zad_almumin/services/animation_service.dart';
import '../classes/block_data.dart';
import '../services/json_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          AnimationService.animationListItemDownToUp(
            index: 1,
            child: ZikrCard.withRandomData(zikrType: ZikrType.quran),
            // child: ZikrCard(zikrData:   JsonService.getQuranData(),)
          ),
          const SizedBox(height: MySiezes.betweanCards),
          AnimationService.animationListItemDownToUp(
              index: 2, child: ZikrCard.withRandomData(zikrType: ZikrType.hadith)),
          const SizedBox(height: MySiezes.betweanCards),
          AnimationService.animationListItemDownToUp(
            child: azkarBlocks(outsideTitle: 'مختلف الاذكار', azkars: BlockData.list, zikrType: ZikrType.azkar),
            index: 3,
          ),
          const SizedBox(height: MySiezes.betweanCards),
          AnimationService.animationListItemDownToUp(
            index: 4,
            child: azkarBlocks(
              outsideTitle: 'اسماء الله الحسنى',
              azkars: [BlockData(imageSource: "assets/images/quran.png", title: 'تعرّف على اسماء الله الحسنى')],
              zikrType: ZikrType.allahNames,
            ),
          ),
        ],
      ),
    );
  }

  azkarBlocks({required String outsideTitle, required List<BlockData> azkars, required ZikrType zikrType}) {
    return (Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: MyTexts.outsideHeader(context, title: outsideTitle),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: MySiezes.heightOfAzkarBlock,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: azkars.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MySiezes.blockRadius),
                      color: MyColors.primary(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.6),
                          blurRadius: 5,
                          offset: Offset(-2, 0),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(minWidth: MySiezes.minAzkarBlockWidth),
                    margin: EdgeInsets.only(left: index != azkars.length - 1 ? MySiezes.betweanAzkarBlock : 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MyTexts.blockTitle(context, title: azkars[index].title),
                        Container(
                          constraints: BoxConstraints(minWidth: MySiezes.minAzkarBlockWidth),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Image.asset(
                                azkars[index].imageSource,
                                width: MySiezes.image,
                              ),
                              MyIcons.leftArrow
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      AzkarPage(
                        zikrIndexInJson: index,
                        zikrType: zikrType,
                      ),
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
    ));
  }
}
