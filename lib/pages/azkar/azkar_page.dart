import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_circular_progress_indicator.dart';
import 'package:zad_almumin/components/zikr_card/zikr_cards.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/services/animation_service.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../../components/my_drawer.dart';

class AzkarPage extends StatefulWidget {
  const AzkarPage({Key? key, this.zikrIndexInJson = 0, this.zikrType = ZikrType.none}) : super(key: key);
  static const String id = 'AzkarPage';
  final int zikrIndexInJson;
  final ZikrType zikrType;

  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  List<ZikrData> zikrDataList = [];
  List<Widget> zikrCardList = [];
  String bigTitle = "";
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    updateTitle();
  }

  @override
  Widget build(BuildContext context) {
    int totalIndex = 0;
    return Scaffold(
      appBar: MyAppBar(title: bigTitle),
      drawer: MyDrawer(),
      body: FutureBuilder(
        future: readData(),
        builder: ((context, snapshot) {
          if (widget.zikrType == ZikrType.none) return Container();

          if (snapshot.connectionState == ConnectionState.waiting) return MyCircularProgressIndicator();

          return AnimationLimiter(
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: zikrDataList.length,
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                if (zikrDataList[index].haveList) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: zikrDataList[index].list.length,
                      itemBuilder: (context, index2) {
                        totalIndex++;
                        return AnimationService.animationListItemDownToUp(
                          index: totalIndex,
                          child: ZikrCard(haveMargin: true).azkarCard(
                            ZikrData(
                              zikrType: widget.zikrType,
                              count: 1,
                              title:
                                  index2 > 0 ? "${zikrDataList[index].title} ${index2 + 1}" : zikrDataList[index].title,
                              content: zikrDataList[index].list[index2]['zekr'] ?? "",
                            ),
                          ),
                        );
                      });
                } else {
                  totalIndex++;
                  return AnimationService.animationListItemDownToUp(
                    index: totalIndex,
                    child: ZikrCard(
                      haveMargin: index != zikrDataList.length - 1 ? true : false,
                    ).azkarCard(zikrDataList[index]),
                  );
                }
              },
            ),
          );
        }),
      ),
    );
  }

  void updateTitle() {
    if (widget.zikrType == ZikrType.azkar)
      bigTitle = JsonService.allZikrDataList[widget.zikrIndexInJson]['title'];
    else if (widget.zikrType == ZikrType.allahNames) bigTitle = "أسماء الله الحسنى";
    bigTitle = bigTitle.tr;
  }

  Future readData() async {
    if (widget.zikrType == ZikrType.azkar)
      zikrDataList = await JsonService.getRandomAzkar(zikrIndexInJson: widget.zikrIndexInJson);
    else if (widget.zikrType == ZikrType.allahNames) zikrDataList = await JsonService.getAllahNames();
  }
}
