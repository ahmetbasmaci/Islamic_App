import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/classes/block_data.dart';
import 'package:zad_almumin/services/animation_service.dart';
import '../pages/azkar_page.dart';

class AzkarBlockScreen extends StatefulWidget {
  const AzkarBlockScreen({Key? key}) : super(key: key);
  static String id = 'AzkarBlockScreen';
  @override
  State<AzkarBlockScreen> createState() => _AzkarBlockScreenState();
}

class _AzkarBlockScreenState extends State<AzkarBlockScreen> {
  List<Widget> list = [];
  @override
  void initState() {
    super.initState();
    //setListData();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Scaffold(
        appBar: MyAppBar(title: 'أذكار المسلم'.tr),
        drawer: MyDrawer(),
        body: ListView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: MyTexts.outsideHeader(title: 'مختلف الأذكار'.tr),
            ),
            ListView.builder(
              itemCount: BlockData.list.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AnimationService.animationListItemDownToUp(
                  index: index,
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
                    margin:
                        EdgeInsets.only(bottom: index != BlockData.list.length - 1 ? MySiezes.betweanAzkarBlock : 0),
                    child: ListTile(
                      title: MyTexts.blockTitle(title: BlockData.list[index].title.tr),
                      leading: Image.asset(BlockData.list[index].imageSource),
                      trailing: MyIcons.leftArrow(color: MyColors.white),
                      onTap: () {
                        Get.to(
                          AzkarPage(
                            zikrIndexInJson: index,
                            zikrType: ZikrType.azkar,
                          ),
                          transition: Transition.size,
                          duration: Duration(milliseconds: 500),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void setListData() {
    for (var index = 0; index < BlockData.list.length; index++) {
      list.add(
        Container(
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
          margin: EdgeInsets.only(bottom: index != BlockData.list.length - 1 ? MySiezes.betweanAzkarBlock : 0),
          child: ListTile(
            title: MyTexts.blockTitle(title: BlockData.list[index].title),
            leading: Image.asset(BlockData.list[index].imageSource),
            trailing: MyIcons.leftArrow(color: MyColors.white),
            onTap: () {
              Get.to(() => AzkarPage(
                    zikrIndexInJson: index,
                    zikrType: ZikrType.azkar,
                  ));
            },
          ),
        ),
      );
    }
  }
}
  // ListView.builder(
  //           itemCount: BlockData.list.length,
  //           shrinkWrap: true,
  //           //physics: AlwaysScrollableScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             return Container(
  //               decoration: MyDecorations.azkarBlkockDecoration,
  //               margin: EdgeInsets.only(bottom: index != BlockData.list.length - 1 ? MySiezes.betweanAzkarBlock : 0),
  //               child: ListTile(
  //                 title: MyTexts.headr_3_2(title: BlockData.list[index].title),
  //                 leading: Image.asset(BlockData.list[index].imageSource),
  //                 trailing: MyIcons.leftArrow,
  //                 onTap: () {
  //                   Navigator.of(context).push(MaterialPageRoute(
  //                       builder: (context) => AzkarPage(
  //                             index: index,
  //                             zikrType: ZikrType.azkar,
  //                           )));
  //                 },
  //               ),
  //             );
  //           },
  //         ),
        