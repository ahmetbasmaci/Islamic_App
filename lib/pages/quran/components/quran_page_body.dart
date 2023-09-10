import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_body_images.dart';
import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/pages/quran/models/ayah_tafseer.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/services/http_service.dart';
import 'package:zad_almumin/services/theme_service.dart';

import '../controllers/quran/tafseers.ctr.dart';

class QuranPageBody extends GetView<ThemeCtr> {
  QuranPageBody({super.key, this.page = 0});
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  final QuranData _quranData = Get.find<QuranData>();
  final AudioCtr _audioCtr = Get.find<AudioCtr>();
  final HttpCtr _httpCtr = Get.find<HttpCtr>();
  final int page;

  @override
  Widget build(BuildContext context) => Obx(() =>
      _quranCtr.showQuranImages.value ? QuranPageBodyImages(page: page) : Stack(children: getQuranTexts(page: page)));

  // @override
  // Widget build(BuildContext context) => Obx(
  //     () => Stack(children: _quranCtr.showQuranImages.value ? getQuranImages(page: page) : getQuranTexts(page: page)));

  // List<Widget> getQuranImages({required int page}) {
  //   List<Widget> images = [
  //     Center(child: Image.asset('assets/images/quran pages/00$page.png', color: MyColors.quranText())),
  //     Center(child: Image.asset('assets/images/quran pages/000$page.png')),
  //   ];
  //   return images;
  // }

  List<Widget> getQuranTexts({required int page}) {
    List<Widget> pages = [];
    List<List<Ayah>> ayahsInPage = _quranData.getAyahsInPage(page);
    List<Ayah> ayahs = [];
    for (var surahAyahs in ayahsInPage) {
      for (var ayah in surahAyahs) {
        ayahs.add(ayah);
      }
    }

    pages.add(
      Container(
        padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: Get.height * 0.01),
        constraints: BoxConstraints(minHeight: Get.height),
        child: Column(
          children: [
            quranUpPart(),
            Expanded(child: quranBodyPart(ayahs)),
            footerPart(),
          ],
        ),
      ),
    );

    return pages;
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
      key: UniqueKey(),
      itemCount: ayahs.length,
      shrinkWrap: true,
      itemScrollController: _quranCtr.itemScrollController2,
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
    return myRichText(
      textSpanChildredn: [
        ...ayahs.map((ayah) => ayah.isBasmalah ? basmalahPart(ayah) : ayahPart(ayah)),
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
        height: Get.height * 0.03,
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
    //set selected ayah
    _quranCtr.updateSelectedAyah(ayah);
    BotToast.showAttachedWidget(
      target: details.globalPosition,
      animationDuration: Duration(microseconds: 700),
      animationReverseDuration: Duration(microseconds: 700),
      attachedBuilder: (cancel) => Card(
        color: MyColors.quranBackGround(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              addAyahMarkBtn(cancel, ayah),
              SizedBox(width: MySiezes.icon / 2),
              copyAyahBtn(cancel, ayah),
              SizedBox(width: MySiezes.icon / 2),
              playAyahBtn(cancel, ayah),
              SizedBox(width: MySiezes.icon / 2),
              shareBtn(cancel, ayah),
            ],
          ),
        ),
      ),
    );
  }

  Container addAyahMarkBtn(CancelFunc cancel, Ayah ayah) {
    return Container(
      height: MySiezes.icon * 2,
      width: MySiezes.icon * 2,
      decoration:
          BoxDecoration(color: MyColors.whiteBlackReversed(), borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        icon: Icon(ayah.isMarked ? Icons.bookmark : Icons.bookmark_border,
            size: MySiezes.icon, color: MyColors.quranPrimary()),
        onPressed: () {
          _quranCtr.addRemoveAyahMark(ayah);
          cancel();
        },
      ),
    );
  }

  Container copyAyahBtn(CancelFunc cancel, Ayah ayah) {
    return Container(
      height: MySiezes.icon * 2,
      width: MySiezes.icon * 2,
      decoration: BoxDecoration(
        color: MyColors.whiteBlackReversed(),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: IconButton(
        icon: Icon(
          Icons.copy_outlined,
          size: MySiezes.icon,
          color: MyColors.quranPrimary(),
        ),
        onPressed: () {
          HelperMethods.copyText(ayah.text);
          cancel();
        },
      ),
    );
  }

  Container playAyahBtn(CancelFunc cancel, Ayah ayah) {
    return Container(
      height: MySiezes.icon * 2,
      decoration:
          BoxDecoration(color: MyColors.whiteBlackReversed(), borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        icon: Icon(
          Icons.play_circle,
          size: MySiezes.icon,
          color: MyColors.quranPrimary(),
        ),
        onPressed: () async {
          cancel();
          List<Ayah> ayahsList = await HttpService.getSurah(surahNumber: ayah.surahNumber);
          _quranCtr.selectedPage.startAyahNum.value = ayah.ayahNumber;
          _quranCtr.changeOnShownState(false);
          _audioCtr.stopAudio();
          if (_httpCtr.downloadComplated.value) {
            _audioCtr.playMultiAudio(ayahList: ayahsList);
          }
        },
      ),
    );
  }

  Container shareBtn(CancelFunc cancel, Ayah ayah) {
    return Container(
      height: MySiezes.icon * 2,
      width: MySiezes.icon * 2,
      decoration:
          BoxDecoration(color: MyColors.whiteBlackReversed(), borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        icon: Icon(
          Icons.share_outlined,
          size: MySiezes.icon,
          color: MyColors.quranPrimary(),
        ),
        onPressed: () {
          Share.share(ayah.text, subject: ayah.surahName);
          cancel();
        },
      ),
    );
  }
}
