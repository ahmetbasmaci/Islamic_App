import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/zikr_card/zikr_cards.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/services/animation_service.dart';
import '../components/my_drawer.dart';

class AzkarPage extends StatefulWidget {
  const AzkarPage({Key? key, this.zikrIndexInJson = 0, this.zikrType = ZikrType.none}) : super(key: key);
  static const String id = 'AzkarPage';
  final int zikrIndexInJson;
  final ZikrType zikrType;

  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  bool isLoading = false;
  List<ZikrData> zikrDataList = [];
  List<Widget> zikrCardList = [];
  String bigTitle = "";
  var scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    readData();
    
  }

  @override
  Widget build(BuildContext context) {
    int totalIndex = 0;
    return Scaffold(
      appBar: MyAppBar(title: bigTitle),
      drawer: MyDrawer(),
      body: widget.zikrType == ZikrType.none
          ? Container()
          : isLoading
              ? Center(child: CircularProgressIndicator())
              : AnimationLimiter(
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
                                child: ZikrCard(
                                  haveMargin: true,
                                ).azkarCard(
                                  ZikrData(
                                    zikrType: widget.zikrType,
                                    title: index2 > 0
                                        ? "${zikrDataList[index].title} ${index2 + 1}"
                                        : zikrDataList[index].title,
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
                ),
    );
  }

  void readData() async {
    setState(() {
      isLoading = true;
    });

    if (widget.zikrType == ZikrType.azkar)
      await readAllAzkar();
    else if (widget.zikrType == ZikrType.allahNames) await readAllahNAmes();

    setState(() {
      isLoading = false;
    });
  }

  Future readAllAzkar() async {
    //read json file
    String json = await rootBundle.loadString('assets/database/azkar/allazkar.json');
    dynamic data = jsonDecode(json);

    bigTitle = data['allAzkar'][widget.zikrIndexInJson]['title'];
    List<dynamic> azkarList = data['allAzkar'][widget.zikrIndexInJson]['azkarList'];
    for (int i = 0; i < azkarList.length; i++) {
      zikrDataList.add(ZikrData(
        zikrType: ZikrType.azkar,
        title: azkarList[i]['title'] ?? "",
        content: azkarList[i]['zekr'] ?? "",
        count: (azkarList[i]['count'] == '' || azkarList[i]['count'] == null) ? 1 : int.parse(azkarList[i]['count']),
        description: azkarList[i]['description'] ?? "",
        haveList: azkarList[i]['haveList'] ?? false,
        list: azkarList[i]['list'] ?? [],
      ));
    }
  }

  Future readAllahNAmes() async {
    //read json file
    String json = await rootBundle.loadString('assets/database/azkar/allahNames.json');
    dynamic data = jsonDecode(json);
    bigTitle = data['title'];
    List<dynamic> allahNamesList = data['list'];
    for (var i = 0; i < allahNamesList.length; i++)
      zikrDataList.add(ZikrData(
          zikrType: ZikrType.allahNames, title: allahNamesList[i]['name'], content: allahNamesList[i]['content']));
  }
}
