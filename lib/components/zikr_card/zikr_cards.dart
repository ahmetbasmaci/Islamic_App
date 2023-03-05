import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/audio_play_stop_btn.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/components/zikr_card/zikr_card_inner_container.dart';
import 'package:zad_almumin/database/sqldb.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/classes/quran_helper.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/animation_service.dart';
import 'package:zad_almumin/services/json_service.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';

class ZikrCard {
  bool isLoading = false;
  bool haveMargin = false;
  VoidCallback? onDeleteFromFavorite;
  ZikrCard({this.isLoading = false, this.haveMargin = false, this.onDeleteFromFavorite});
  final QuranData _quranData = Get.find<QuranData>();
  final QuranHelper _quranHelper = QuranHelper();
  Widget outContainer(
      {required Widget child,
      String? outsideTitle,
      VoidCallback? onTap,
      VoidCallback? onTapUp,
      required bool isFavorite}) {
    return Container(
      // duration: Duration(milliseconds: 1000),
      padding: EdgeInsets.only(bottom: haveMargin ? MySiezes.betweanAzkarBlock : 0),
      margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding, vertical: MySiezes.screenPadding),
      child: Column(
        children: <Widget>[
          outsideTitle != null && !isFavorite
              ? Align(alignment: Alignment.centerRight, child: MyTexts.outsideHeader(title: outsideTitle))
              : Container(),
          AnimatedButtonTapping(
            onTap: onTap,
            onTapUp: onTapUp,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(MySiezes.blockRadius)),
              padding: EdgeInsets.all(MySiezes.cardPadding),
              child: Container(constraints: BoxConstraints(minHeight: 150, minWidth: double.maxFinite), child: child),
            ),
          ),
        ],
      ),
    );
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
    Future<ZikrData?> myFuture = Future.delayed(Duration(seconds: 0));
    if (isNewAyah) {
      myFuture = Future.delayed(Duration(seconds: 0)).then((value) async {
        while (_quranData.isEmpty) await Future.delayed(Duration(seconds: 1));

        return await _quranHelper.getRandomZikrDataAyah();
      });
    }
    return outContainer(
      outsideTitle: 'اية من القران الكريم',
      isFavorite: quranZikrData != null,
      child: StatefulBuilder(builder: (context, setState) {
        return FutureBuilder<ZikrData?>(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else if (snapshot.connectionState == ConnectionState.waiting) return MyCircularProgressIndecator();
            // else if (!snapshot.hasData) return MyCircularProgressIndecator();
            if (isNewAyah) quranZikrData = snapshot.data as ZikrData;
            return ZikrCardInnerContainer(
              zikrData: quranZikrData!,
              firstChild: onDeleteFromFavorite == null
                  ? IconButton(
                      onPressed: () async {
                        quranZikrData = null;

                        myFuture =
                            Future.delayed(Duration(seconds: 0)).then((value) => _quranHelper.getRandomZikrDataAyah());
                        autoPlaySound = false;
                        try {
                          setState(() {});
                        } catch (e) {
                          print("ERROR IN ZIKR CARD: $e");
                        }
                      },
                      icon: MyIcons.refresh)
                  : null,
              secondChild: AudioPlayStopBtn(
                zikrData: quranZikrData!,
                autoPlay: autoPlaySound,
                onComplite: () async {
                  myFuture = Future.delayed(Duration(seconds: 0)).then(
                      (value) => _quranHelper.getZikDataAyah(quranZikrData!.ayahNumber, quranZikrData!.surahNumber));
                  autoPlaySound = true;
                  checkIfIsFavorite(quranZikrData!);

                  try {
                    setState(() {});
                  } catch (e) {
                    print("ERROR IN ZIKR CARD: $e");
                  }
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
    if (hadithZikrData == null) myFuture = JsonService.getRandomHadith();
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

              return ZikrCardInnerContainer(
                zikrData: hadithZikrData!,
                firstChild: onDeleteFromFavorite == null
                    ? IconButton(
                        onPressed: () {
                          hadithZikrData = null;
                          myFuture = JsonService.getRandomHadith();
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
    if (azkarZikrData.zikrType == ZikrType.allahNames) return allahNamesCard(azkarZikrData);
    return StatefulBuilder(builder: (context, setState) {
      return outContainer(
        isFavorite: azkarZikrData.isFavorite,
        onTap: azkarZikrData.count > 0
            ? () async {
                //azkarZikrData.count--;
                //await Future.delayed(Duration(milliseconds: 300));
                //setState(() {});
              }
            : null,
        onTapUp: azkarZikrData.count > 0
            ? () async {
                azkarZikrData.count--;
                //await Future.delayed(Duration(milliseconds: 300));
                setState(() {});
              }
            : null,
        child: ZikrCardInnerContainer(
          zikrData: azkarZikrData,
          firstChild: AnimatedOpacity(
            duration: Duration(milliseconds: 5000),
            opacity: 1,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: MyColors.zikrCard(),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: MyColors.primary(),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: MyTexts.content(
                title: azkarZikrData.count > 0 ? '${azkarZikrData.count}' : 'تم',
                color: azkarZikrData.count > 0 ? null : MyColors.primary(),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget allahNamesCard(ZikrData allahNamesZikrData) {
    return outContainer(
      isFavorite: allahNamesZikrData.isFavorite,
      child: ZikrCardInnerContainer(zikrData: allahNamesZikrData),
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
