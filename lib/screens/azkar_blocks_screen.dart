import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/classes/block_data.dart';
import '../services/theme_service.dart';
import '../pages/azkar_page.dart';

class AzkarBlockScreen extends StatefulWidget {
  const AzkarBlockScreen({Key? key}) : super(key: key);

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
    return ListView(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: MyTexts.outsideHeader(context, title: 'مختلف الاذكار'),
        ),
        ListView.builder(
          itemCount: BlockData.list.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
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
                title: MyTexts.blockTitle(context, title: BlockData.list[index].title),
                leading: Image.asset(BlockData.list[index].imageSource),
                trailing: MyIcons.leftArrow,
                onTap: () {
                  Get.to(AzkarPage(
                    zikrIndexInJson: index,
                    zikrType: ZikrType.azkar,
                  ));
                },
              ),
            );
          },
        ),
      ],
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
            title: MyTexts.blockTitle(context, title: BlockData.list[index].title),
            leading: Image.asset(BlockData.list[index].imageSource),
            trailing: MyIcons.leftArrow,
            onTap: () {
              Get.to(AzkarPage(
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
        