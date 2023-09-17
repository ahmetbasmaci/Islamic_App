import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/components/bottoast_dialog.dart';
import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/pages/quran/models/ayah_tafseer.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/theme_service.dart';

import '../controllers/quran/tafseers.ctr.dart';

class QuranPageBodyTexts extends GetView<ThemeCtr> {
  QuranPageBodyTexts({super.key, this.page = 0});
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  final QuranData _quranData = Get.find<QuranData>();
  final int page;

  @override
  Widget build(BuildContext context) {
    List<List<Ayah>> ayahsInPage = _quranData.getAyahsInPage(page);
    List<Ayah> ayahs = [];
    for (var surahAyahs in ayahsInPage) {
      for (var ayah in surahAyahs) {
        ayahs.add(ayah);
      }
    }

    return Container(
      padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: Get.height * 0.01),
      constraints: BoxConstraints(minHeight: Get.height),
      child: Column(
        children: [
          quranUpPart(),
          Expanded(child: quranBodyPart(ayahs)),
          footerPart(),
        ],
      ),
    );
  }

  Widget quranUpPart() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
        height: AppSettings.quranUpPartHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTexts.quran(
              title: '${'الجُزْءُ'}   ${_quranData.getJuzNumberByPage(page)}',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.quranPrimary(),
            ),
            MyTexts.quran(
              title: '${_quranCtr.selectedPage.surahName}',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.quranPrimary(),
            ),
          ],
        ),
      ),
    );
  }

  Widget quranBodyPart(List<Ayah> ayahs) {
    return Obx(() {
      return _quranCtr.showTafseerPage.value ? getQuranTafseePart(ayahs) : getQuranTextPart(ayahs);
    });
  }

  Widget getQuranTafseePart(List<Ayah> ayahs) {
    return ScrollablePositionedList.builder(
      itemCount: ayahs.length,
      shrinkWrap: true,
      itemScrollController: _quranCtr.getItemScrollController(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        Ayah ayah = ayahs[index];
        return Obx(
          () => ayah.isBasmalah
              ? myRichText(textSpanChildredn: [basmalahPart(ayah)])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myRichText(
                      textSpanChildredn: [
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding / 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(MySiezes.blockRadius),
                              color: _quranCtr.selectedAyah.value.ayahNumber == ayah.ayahNumber &&
                                      _quranCtr.selectedAyah.value.surahNumber == ayah.surahNumber
                                  ? MyColors.quranPrimary().withOpacity(0.5)
                                  : ayah.isMarked
                                      ? MyColors.markedAyah().withOpacity(0.2)
                                      : Colors.transparent,
                            ),
                            child: myRichText(textSpanChildredn: [ayahPart(ayah)]),
                          ),
                        )
                      ],
                    ),
                    tafseerPart(ayah),
                  ],
                ),
        );
      },
    );
  }

  Widget getQuranTextPart(List<Ayah> ayahs) {
    return ListView(
      controller: _quranCtr.scrollController,
      children: [
        myRichText(
          textSpanChildredn: [
            ...ayahs.map((ayah) => ayah.isBasmalah ? basmalahPart(ayah) : ayahPart(ayah)),
          ],
        ),
      ],
    );
  }

  RichText myRichText({required List<InlineSpan> textSpanChildredn}) {
    return RichText(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        children: textSpanChildredn,
        style: MyTexts.quranStyle(fontSize: _quranCtr.quranFontSize.value),
      ),
    );
  }

  WidgetSpan basmalahPart(Ayah ayah) {
    // if(ayah.){
    //   Scrollable.ensureVisible(context)
    // }
    return WidgetSpan(
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/images/surah_header.png",
                      height: _quranCtr.quranFontSize.value * 1.6,
                      width: double.maxFinite,
                      fit: BoxFit.fill,
                      color: MyColors.primary(),
                    ),
                    Center(
                      heightFactor: .9,
                      child: MyTexts.quran(
                        textAlign: TextAlign.center,
                        title: ayah.surahName,
                        fontSize: _quranCtr.quranFontSize.value * 1.05,
                        fontWeight: FontWeight.bold,
                        color: MyColors.primary(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/images/bismillah.png",
            height: _quranCtr.quranFontSize.value * 1.6,
            color: MyColors.whiteBlack(),
          ),
        ],
      ),
    );
  }

  TextSpan ayahPart(Ayah ayah) {
    return TextSpan(
      text: ayah.text,
      style: TextStyle(
        fontWeight: ayah.isBasmalah ? FontWeight.bold : null,
        wordSpacing: -1,
        color: MyColors.whiteBlack(),
        background: Paint()
          ..color = _quranCtr.showTafseerPage.value
              ? Colors.transparent
              : _quranCtr.selectedAyah.value.ayahNumber == ayah.ayahNumber &&
                      _quranCtr.selectedAyah.value.surahNumber == ayah.surahNumber
                  ? MyColors.quranPrimary().withOpacity(0.2)
                  : ayah.isMarked
                      ? MyColors.markedAyah().withOpacity(0.2)
                      : Colors.transparent
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill,
      ),
      recognizer: LongPressGestureRecognizer()..onLongPressStart = (details) => onAyahLongPressStart(details, ayah),
      children: [
        TextSpan(
          text: ' ${HelperMethods.convertToArabicNumber(ayah.ayahNumber)} ',
          style: TextStyle(
            wordSpacing: 0,
            fontWeight: FontWeight.bold,
            fontFamily: MyFonts.uthmanic2.name,
            color: MyColors.quranPrimary(),
          ),
        ),
        _quranCtr.showTafseerPage.value
            ? WidgetSpan(
                child: Container(
                  color: Colors.red,
                  child: MyTexts.quran(title: ""),
                ),
              )
            : TextSpan(),
      ],
    );
  }

  Widget tafseerPart(Ayah ayah) {
    List<SurahTafseer> allTafseer = Get.find<TafseersCtr>().allTafseer;
    String tafseerText = allTafseer
        .firstWhere((x) => x.surahNumber == ayah.surahNumber)
        .ayahsTafseer
        .firstWhere((x) => x.ayahNumber == ayah.ayahNumber)
        .tafseerText;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MySiezes.blockRadius),
        color: MyColors.primary().withOpacity(.15),
      ),
      padding: EdgeInsets.all(MySiezes.screenPadding),
      margin: EdgeInsets.symmetric(vertical: MySiezes.screenPadding),
      child: MyTexts.quran(
        title: tafseerText,
        textAlign: TextAlign.justify,
        // textAlign: AppSettings.isArabicLang ? TextAlign.right : TextAlign.left,
        color: MyColors.whiteBlack(),
        fontSize: _quranCtr.quranFontSize.value,
      ),
    );
  }

  Widget footerPart() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: Get.height * 0.02,
        child: Center(
          child: MyTexts.quran(
            title: HelperMethods.convertToArabicNumber(page),
            // size: 16,
            fontWeight: FontWeight.bold,
            color: MyColors.quranPrimary(),
          ),
        ),
      ),
    );
  }

  void onAyahLongPressStart(LongPressStartDetails details, Ayah ayah) {
    _quranCtr.updateSelectedAyah(ayah); //set selected ayah

    BotToastDialog.showToastDialog(details: details, ayah: ayah);
  }
}