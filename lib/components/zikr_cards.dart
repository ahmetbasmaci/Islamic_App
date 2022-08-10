import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../classes/zikr_data.dart';
import '../constents/colors.dart';
import '../constents/icons.dart';
import '../constents/sizes.dart';
import '../constents/texts.dart';
import '../database/sqldb.dart';
import '../services/animation_service.dart';
import '../services/theme_service.dart';
import 'zikr_block_buttons.dart';
import 'audio_play_stop_btn.dart';
import 'my_circular_progress_indecator.dart';

class ZikrCard2 {
  
  static quranCard(){

  }
}




class ZikrCard extends StatefulWidget {
  ZikrCard({
    Key? key,
    required this.zikrData,
    this.onDeleteFromFavorite,
    this.haveMargin = false,
    this.scrollController,
  }) : super(key: key);
  ZikrCard.withRandomData({required ZikrType zikrType}) {
    zikrData.zikrType = zikrType;
  }
  ZikrData zikrData = ZikrData();
  VoidCallback? onDeleteFromFavorite;
  bool haveMargin = false;
  ScrollController? scrollController;

  @override
  State<ZikrCard> createState() => _ZikrCardState();
}

class _ZikrCardState extends State<ZikrCard> {
  bool isLoading = false;
  bool zikrCountComplated = false;
  bool initilized = false;
  @override
  void initState() {
    super.initState();
    getRandomData();
  }

  // checkIfNewData() async {
  //   if (initilized)
  //     await getOldData();
  //   else
  //     await getRandomData();
  // }

  // getOldData() async {
  //   GetStorage storage = GetStorage();
  //   var data = await storage.read(widget.zikrData.zikrType.name);
  //   widget.zikrData.fromJson(data);
  //   if (mounted) setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return widget.zikrData.zikrType == ZikrType.quran
        ? quranCard()
        : widget.zikrData.zikrType == ZikrType.hadith
            ? hadithCard()
            : widget.zikrData.zikrType == ZikrType.azkar
                ? azkarCard()
                : widget.zikrData.zikrType == ZikrType.allahNames
                    ? allahNamesCard()
                    : Container();
  }

  Widget basicZikrCard({
    String outsideTitle = '',
    Widget? firstChild,
    Widget? secondChild,
    bool canPress = false,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: widget.haveMargin ? MySiezes.betweanAzkarBlock : 0),
      margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
      child: Column(
        children: <Widget>[
          //outside header
          Align(alignment: Alignment.centerRight, child: MyTexts.outsideHeader(context, title: outsideTitle)),
          AnimatedButtonTapping(
            onTap: zikrCountComplated || !canPress
                ? null
                : () {
                    if (widget.zikrData.count > 0) {
                      widget.zikrData.count--;
                      // writeDataToDb();
                      // setState(() {});
                    }
                    if (widget.zikrData.count == 0) {
                      setState(() {
                        zikrCountComplated = true;
                      });
                      widget.scrollController!
                          .animateTo(2000, duration: Duration(milliseconds: 500), curve: Curves.ease);
                    }
                  },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MySiezes.blockRadius),
                color: MyColors.zikrCard(),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.5), blurRadius: 10, offset: Offset(0, 5)),
                  BoxShadow(color: MyColors.primary().withOpacity(.5), blurRadius: 5, offset: Offset(0, 0)),
                ],
              ),
              padding: EdgeInsets.all(MySiezes.cardPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      firstChild ?? Container(),
                      Expanded(child: Center(child: MyTexts.zikrTitle(context, title: widget.zikrData.title))),
                      secondChild ?? Container(),
                    ],
                  ),
                  isLoading
                      ? const MyCircularProgressIndecator()
                      : MyTexts.content(context, title: widget.zikrData.content),
                  widget.zikrData.description != ''
                      ? Row(
                          children: [
                            MyIcons.info,
                            Expanded(child: MyTexts.info(context, title: widget.zikrData.description)),
                          ],
                        )
                      : Container(),
                  ZikrBlockButtons(zikrData: widget.zikrData, onDeleteFromFavorite: widget.onDeleteFromFavorite)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget quranCard() {
    return basicZikrCard(
      outsideTitle: 'اية من القران الكريم',
      firstChild: widget.onDeleteFromFavorite == null
          ? IconButton(onPressed: () => getRandomData(), icon: MyIcons.refresh)
          : null,
      secondChild: AudioPlayStopBtn(
        zikrData: widget.zikrData,
        onComplite: () async {
          isLoading = true;
          if (mounted) setState(() {});
          widget.zikrData = await JsonService.getSpesificQuranData(
              numberInQuran: widget.zikrData.numberInQuran + 1, surahNumber: widget.zikrData.surahNumber);
          checkIfIsFavorite();
          isLoading = false;
          if (mounted) setState(() {});
        },
      ),
    );
  }

  Widget hadithCard() {
    return basicZikrCard(
      outsideTitle: 'بلّفو عني ولو اية',
      firstChild: widget.onDeleteFromFavorite == null
          ? IconButton(onPressed: () => getRandomData(), icon: MyIcons.refresh)
          : null,
    );
  }

  Widget azkarCard() {
    return basicZikrCard(
        firstChild: widget.zikrData.count < 0
            ? Container()
            : Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: zikrCountComplated ? MyColors.currect() : MyColors.zikrCard(),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-5, 0),
                      color:
                          ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.black : MyColors.lightModeShadow,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: MyTexts.content(context, title: '${widget.zikrData.count}'),
              ),
        canPress: true);
  }

  Widget allahNamesCard() {
    return basicZikrCard();
  }

  Future getRandomData() async {
    isLoading = true;
    if (mounted) setState(() {});
    await Future.delayed(Duration(milliseconds: 300));
    if (ZikrType.quran == widget.zikrData.zikrType)
      widget.zikrData = await JsonService.getQuranData(true);
    else if (ZikrType.hadith == widget.zikrData.zikrType)
      widget.zikrData = await JsonService.getHadithData();
    else if (ZikrType.sermon == widget.zikrData.zikrType) return;

    writeDataToDb();
    initilized = true;

    checkIfIsFavorite();
    isLoading = false;
    if (mounted) setState(() {});
  }

  writeDataToDb() {
    GetStorage storage = GetStorage();
    storage.write(widget.zikrData.zikrType.name, widget.zikrData.toJson());
  }

  checkIfIsFavorite() async {
    widget.zikrData.isFavorite = false;
    SqlDb sqlDb = SqlDb();
    List<Map> data = await sqlDb.readData(SqlDb.dbName);
    for (var i = 0; i < data.length; i++) {
      if (data[i]['content'] == widget.zikrData.content) {
        widget.zikrData.isFavorite = true;
        break;
      }
    }
  }
}
