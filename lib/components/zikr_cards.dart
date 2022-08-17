import 'package:flutter/material.dart';
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
  bool isLoading = false;
  bool haveMargin = false;
  VoidCallback? onDeleteFromFavorite;
  ZikrCard2({this.isLoading = false, this.haveMargin = false, this.onDeleteFromFavorite});

  Widget outContainer({required Widget child, String? outsideTitle, VoidCallback? onTap, required bool isFavorite}) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        // duration: Duration(milliseconds: 1000),
        padding: EdgeInsets.only(bottom: haveMargin ? MySiezes.betweanAzkarBlock : 0),
        margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding, vertical: MySiezes.screenPadding),
        child: Column(
          children: <Widget>[
            //outside header
            outsideTitle != null && !isFavorite
                ? Align(alignment: Alignment.centerRight, child: MyTexts.outsideHeader(context, title: outsideTitle))
                : Container(),
            AnimatedButtonTapping(
              onTap: onTap,
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MySiezes.blockRadius),
                    color: MyColors.zikrCard(),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(.5), blurRadius: 10, offset: Offset(0, 5)),
                      BoxShadow(color: MyColors.primary().withOpacity(.5), blurRadius: 5, offset: Offset(0, 0)),
                    ],
                  ),
                  padding: EdgeInsets.all(MySiezes.cardPadding),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 150, //minimum height
                      minWidth: double.maxFinite, // minimum width
                    ),
                    child: child,
                  )),
            ),
          ],
        ),
      );
    });
  }

  Widget insideContainer({
    required ZikrData zikrData,
    Widget? firstChild,
    Widget? secondChild,
  }) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              firstChild ?? Container(),
              Expanded(child: Center(child: MyTexts.zikrTitle(context, title: zikrData.title))),
              secondChild ?? Container(),
            ],
          ),
          MyTexts.content(context, title: zikrData.content),
          zikrData.description != ''
              ? Row(children: [MyIcons.info, Expanded(child: MyTexts.info(context, title: zikrData.description))])
              : Container(),
          ZikrBlockButtons(zikrData: zikrData, onDeleteFromFavorite: onDeleteFromFavorite)
        ],
      );
    });
  }

  Widget byType(ZikrData zikrData) {
    Widget child = Container();
    if (zikrData.zikrType == ZikrType.quran)
      child = quranCard(quranZikrData: zikrData);
    else if (zikrData.zikrType == ZikrType.hadith)
      child = hadithCard(hadithZikrData: zikrData);
    else if (zikrData.zikrType == ZikrType.azkar)
      child = azkarCard(zikrData);
    else if (zikrData.zikrType == ZikrType.allahNames) child = allahNamesCard(zikrData);

    return child;
  }

  Widget quranCard({ZikrData? quranZikrData}) {
    bool isNewAyah = quranZikrData == null;
    bool autoPlaySound = false;
    Future myFuture = Future.delayed(Duration(seconds: 0));
    if (isNewAyah) myFuture = JsonService.getQuranData();
    return outContainer(
      outsideTitle: 'اية من القران الكريم',
      isFavorite: quranZikrData != null,
      child: StatefulBuilder(builder: (context, setState) {
        return FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else if (snapshot.connectionState == ConnectionState.waiting) return MyCircularProgressIndecator();
            if (isNewAyah) quranZikrData = snapshot.data as ZikrData;
            return insideContainer(
              zikrData: quranZikrData!,
              firstChild: onDeleteFromFavorite == null
                  ? IconButton(
                      onPressed: () async {
                        quranZikrData = null;

                        myFuture = JsonService.getQuranData();
                        autoPlaySound = false;
                        setState(() {});
                      },
                      icon: MyIcons.refresh)
                  : null,
              secondChild: AudioPlayStopBtn(
                zikrData: quranZikrData!,
                autoPlay: autoPlaySound,
                onComplite: () async {
                  myFuture = JsonService.getSpesificQuranData(
                      numberInQuran: quranZikrData!.numberInQuran, surahNumber: quranZikrData!.surahNumber);
                  autoPlaySound = true;
                  checkIfIsFavorite(quranZikrData!);

                  setState(() {});
                },
              ),
            );
          },
        );
      }),
    );
  }

  Widget hadithCard({ZikrData? hadithZikrData}) {
    Future myFuture = Future.delayed(Duration(seconds: 0));
    if (hadithZikrData == null) myFuture = JsonService.getHadithData();
    return outContainer(
      outsideTitle: 'بلّفو عني ولو اية',
      isFavorite: hadithZikrData != null,
      child: StatefulBuilder(builder: (context, setState) {
        return FutureBuilder(
            future: myFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
              if (snapshot.connectionState == ConnectionState.waiting) return MyCircularProgressIndecator();
              hadithZikrData ??= snapshot.data as ZikrData;

              return insideContainer(
                zikrData: hadithZikrData!,
                firstChild: onDeleteFromFavorite == null
                    ? IconButton(
                        onPressed: () {
                          hadithZikrData = null;
                          myFuture = JsonService.getHadithData();
                          setState(() {});
                        },
                        icon: MyIcons.refresh)
                    : null,
              );
            });
      }),
    );
  }

  Widget azkarCard(ZikrData azkarZikrData) {
    return StatefulBuilder(builder: (context, setState) {
      Widget isDoneWidget({required Widget child}) => azkarZikrData.count <= 0
          ? Banner(
              location: BannerLocation.topEnd,
              color: azkarZikrData.count <= 0 ? MyColors.currect() : MyColors.zikrCard(),
              message: 'تم',
              child: child)
          : Container(child: child);
      return isDoneWidget(
        child: outContainer(
          isFavorite: azkarZikrData.isFavorite,
          onTap: azkarZikrData.count > 0
              ? () {
                  if (azkarZikrData.count > 0) {
                    azkarZikrData.count--;
                    setState(() {});
                  }
                }
              : null,
          child: insideContainer(
            zikrData: azkarZikrData,
            firstChild: AnimatedOpacity(
              duration: Duration(milliseconds: 5000),
              opacity: 1,
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: azkarZikrData.count <= 0 ? MyColors.currect() : MyColors.zikrCard(),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-5, 0),
                        color:
                            ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.black : MyColors.lightModeShadow,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: MyTexts.content(context, title: '${azkarZikrData.count}')),
            ),
          ),
        ),
      );
    });
  }

  Widget allahNamesCard(ZikrData allahNamesZikrData) {
    return outContainer(
      isFavorite: allahNamesZikrData.isFavorite,
      child: insideContainer(zikrData: allahNamesZikrData),
    );
  }

  checkIfIsFavorite(ZikrData zikrData) async {
    zikrData.isFavorite = false;
    SqlDb sqlDb = SqlDb();
    List<Map> data = await sqlDb.readData(SqlDb.dbName);
    for (var i = 0; i < data.length; i++) {
      if (data[i]['content'] == zikrData.content) {
        zikrData.isFavorite = true;
        break;
      }
    }
  }
}
