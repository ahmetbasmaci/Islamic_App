import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/audio_play_stop_btn.dart';
import 'package:zad_almumin/components/my_indicator.dart';
import 'package:zad_almumin/components/zikr_card/referesh_btn_rounded.dart';
import 'package:zad_almumin/components/zikr_card/zikr_card_inner_container.dart';
import 'package:zad_almumin/components/zikr_card/zikr_count_widget.dart';
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/database/sqldb.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/animation_service.dart';
import 'package:zad_almumin/services/audio_service/audio_service.dart';
import 'package:zad_almumin/services/json_service.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';

class ZikrCard {
  bool isLoading = false;
  bool haveMargin = false;
  VoidCallback? onDeleteFromFavorite;
  ZikrCard({this.isLoading = false, this.haveMargin = false, this.onDeleteFromFavorite});
  final QuranData _quranData = Get.find<QuranData>();
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  Widget outContainer(
      {required Widget child,
      String? outsideTitle,
      VoidCallback? onTap,
      VoidCallback? onTapUp,
      BoxShadow? shadow,
      required bool isFavorite}) {
    return Container(
      // duration: Duration(milliseconds: 1000),
      padding: EdgeInsets.only(bottom: haveMargin ? MySiezes.betweanAzkarBlock : 0),
      margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding, vertical: MySiezes.screenPadding),
      child: Column(
        children: <Widget>[
          outsideTitle != null && !isFavorite
              ? Align(
                  alignment: AppSettings.isArabicLang ? Alignment.centerRight : Alignment.bottomLeft,
                  child: MyTexts.outsideHeader(title: outsideTitle, color: MyColors.primary))
              : Container(),
          AnimatedButtonTapping(
            onTap: onTap,
            onTapUp: onTapUp,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MySiezes.blockRadius),
                  boxShadow: [shadow ?? BoxShadow(color: Colors.transparent)]),
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

        return await _quranCtr.getRandomZikrDataAyah();
      });
    }
    return outContainer(
      outsideTitle: 'آية من القرآن الكريم'.tr,
      isFavorite: quranZikrData != null,
      child: StatefulBuilder(builder: (context, setState) {
        return FutureBuilder<ZikrData?>(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else if (snapshot.connectionState == ConnectionState.waiting) return MyCircularProgressIndicator();
            // else if (!snapshot.hasData) return MyCircularProgressIndecator();
            if (isNewAyah) quranZikrData = snapshot.data as ZikrData;
            return ZikrCardInnerContainer(
              zikrData: quranZikrData!,
              rigthTopChild: onDeleteFromFavorite == null
                  ? RefereshBtnRounded(
                      enabled: !isLoading,
                      onPress: () async {
                        quranZikrData = null;
                        myFuture = _quranCtr.getRandomZikrDataAyah();
                        autoPlaySound = false;
                        AudioService.stopAudio();
                        try {
                          setState(() {});
                        } catch (e) {
                          print("ERROR IN ZIKR CARD: $e");
                        }
                      })
                  // AnimatedButton(
                  //     color: MyColors.zikrCard,
                  //     width: MySiezes.btnIcon,
                  //     height: MySiezes.btnIcon,
                  //     enabled: !isLoading,
                  //     onPressed: () async {
                  //       quranZikrData = null;
                  //       myFuture =
                  //           Future.delayed(Duration(seconds: 0)).then((value) => _quranCtr.getRandomZikrDataAyah());
                  //       autoPlaySound = false;
                  //       _audioCtr.stopAudio();
                  //       try {
                  //         setState(() {});
                  //       } catch (e) {
                  //         print("ERROR IN ZIKR CARD: $e");
                  //       }
                  //     },
                  //     child: MyIcons.refresh,
                  //   )
                  : null,
              leftTopChild: AudioPlayStopBtn(
                zikrData: quranZikrData!,
                autoPlay: autoPlaySound,
                onComplite: () async {
                  myFuture = _quranCtr.getNextAyah(quranZikrData!.surahNumber, quranZikrData!.ayahNumber);
                  autoPlaySound = true;
                  if (quranZikrData != null) checkIfIsFavorite(quranZikrData!);

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
    if (hadithZikrData == null)
      myFuture = Future.delayed(Duration(seconds: 0)).then((value) => JsonService.getRandomHadith());
    return outContainer(
      outsideTitle: 'بلّغو عني ولوآية'.tr,
      isFavorite: hadithZikrData != null,
      child: StatefulBuilder(builder: (context, setState) {
        return FutureBuilder(
            future: myFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
              if (snapshot.connectionState == ConnectionState.waiting) return MyCircularProgressIndicator();
              hadithZikrData ??= snapshot.data as ZikrData;

              return ZikrCardInnerContainer(
                zikrData: hadithZikrData!,
                rigthTopChild: onDeleteFromFavorite == null
                    ? RefereshBtnRounded(onPress: () {
                        hadithZikrData = null;
                        myFuture = myFuture =
                            Future.delayed(Duration(seconds: 0)).then((value) => JsonService.getRandomHadith());
                        try {
                          setState(() {});
                        } catch (e) {
                          print("ERROR IN ZIKR CARD: $e");
                        }
                      })
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
        onTap: azkarZikrData.count > 0 ? () {} : null,
        onTapUp: azkarZikrData.count > 0
            ? () async {
                azkarZikrData.count--;
                try {
                  setState(() {});
                } catch (e) {
                  print("ERROR IN ZIKR CARD: $e");
                }
              }
            : null,
        shadow: azkarZikrData.count > 0
            ? null
            : BoxShadow(
                offset: Offset(0, 0),
                color: MyColors.primary.withOpacity(1),
                blurRadius: 5,
                spreadRadius: 2,
                blurStyle: BlurStyle.outer,
              ),
        child: ZikrCardInnerContainer(
          zikrData: azkarZikrData,
          rigthTopChild: AnimatedOpacity(
            duration: Duration(milliseconds: 5000),
            opacity: 1,
            child: ZikrCountWidget(title: azkarZikrData.count > 0 ? '${azkarZikrData.count}' : 'تم'.tr),
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
