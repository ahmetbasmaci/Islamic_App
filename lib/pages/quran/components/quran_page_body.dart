import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/constants.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/controllers/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/services/http_service.dart';
import 'package:zad_almumin/services/theme_service.dart';

class QuranPageBody extends GetView<ThemeCtr> {
  QuranPageBody({super.key, this.page = 0});
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  final QuranData _quranData = Get.find<QuranData>();
  final AudioCtr _audioCtr = Get.find<AudioCtr>();
  final HttpCtr _httpCtr = Get.find<HttpCtr>();
  final int page;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: _quranCtr.showAsImages.value ? getQuranImages(page: page) : getQuranTexts(page: page),
      ),
    );
  }

  List<Widget> getQuranImages({required int page}) {
    List<Widget> images = [
      Center(child: Image.asset('assets/images/quran pages/00$page.png', color: MyColors.quranText())),
      Center(child: Image.asset('assets/images/quran pages/000$page.png')),
    ];
    return images;
  }

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
        padding: EdgeInsets.only(left: Get.width * 0.01, right: Get.width * 0.01, bottom: Get.height * 0.01),
        constraints: BoxConstraints(minHeight: Get.height),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                height: Constants.quranUpPartHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTexts.quran2(
                      title: 'الجُزْءُ   ${_quranData.getJuzNumberByPage(page)}',
                      size: 20,
                      fontWeight: FontWeight.bold,
                      color: MyColors.quranPrimary(),
                    ),
                    MyTexts.quran2(
                      title: '${_quranCtr.selectedPage.surahName}',
                      size: 20,
                      fontWeight: FontWeight.bold,
                      color: MyColors.quranPrimary(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Obx(
                    () => RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          ...ayahs.map(
                            (ayah) => TextSpan(
                              text: ayah.text,
                              style: TextStyle(
                                // fontFamily: MyFonts.uthmanic.name,
                                wordSpacing: -1,
                                color: ayah.isBasmalah ? MyColors.quranPrimary() : null,
                                fontSize: ayah.isBasmalah ? _quranCtr.quranFontSize.value * 1.05 : null,
                                background: Paint()
                                  ..color = _quranCtr.selectedAyah.value.ayahNumber == ayah.ayahNumber &&
                                          _quranCtr.selectedAyah.value.surahNumber == ayah.surahNumber
                                      ? MyColors.quranPrimary().withOpacity(0.2)
                                      : ayah.isMarked
                                          ? MyColors.markedAyah().withOpacity(0.2)
                                          : Colors.transparent
                                  ..strokeJoin = StrokeJoin.round
                                  ..strokeCap = StrokeCap.round
                                  ..style = PaintingStyle.fill,
                              ),
                              recognizer: LongPressGestureRecognizer()
                                ..onLongPressStart =
                                    (details) => ayah.isBasmalah ? {} : onAyahLongPressStart(details, ayah),
                              children: [
                                TextSpan(
                                  text: ' ${HelperMethods.convertToArabicNumber(ayah.ayahNumber)} ',
                                  style: TextStyle(
                                    wordSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: MyFonts.uthmanic2.name,
                                    color: MyColors.quranPrimary(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                        style: MyTexts.quran(title: '', size: _quranCtr.quranFontSize.value).style!.copyWith(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                child: MyTexts.quran(
                  title: HelperMethods.convertToArabicNumber(page),
                  size: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.quranPrimary(),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return pages;
  }

  void onAyahLongPressStart(LongPressStartDetails details, Ayah ayah) {
    //set selected ayah
    _quranCtr.selectedAyah.value = ayah;
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
              //??original cod
              /*
                                Container(
                                  color: Colors.red,
                                ),
                                Container(
                                  height   MySiezes.icon*2,
                                  decoration: BoxD:  MySiezes.icon*2,
                                  width:ecoration(
                                      color: Color(0xfff3efdf),
                                      borderRadius: BorderRadius.all(Radius.circular(50))),
                                  child: FutureBuilder<List<Ayat>>(
                                      future: QuranCubit.get(context)
                                          .handleRadioValueChanged(
                                              QuranCubit.get(context).radioValue)
                                          .getAyahTranslate((widget.surah!.number)),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          List<Ayat>? ayat = snapshot.data;
                                          Ayat aya = Ayat();
                                          return IconButton(
                                            icon: Icon(
                                              Icons.text_snippet_outlined,
                                              size:  MySiezes.icon,
                                              color: MyColors.quranPrimary(),
                                            ),
                                            onPressed: () {
                                              TextCubit.translateAyah = "${aya.ayatext}";
                                              TextCubit.translate = "${aya.translate}";
                                              // showModalBottomSheet<void>(
                                              //   context: context,
                                              //   builder: (BuildContext context) {
                                              //     return ShowTextTafseer();
                                              //   },
                                              // );
                                              if (TextCubit.isShowBottomSheet) {
                                                Navigator.pop(context);
                                              } else {
                                                TPageScaffoldKey.currentState?.showBottomSheet(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(8),
                                                            topRight: Radius.circular(8))),
                                                    backgroundColor: Colors.transparent,
                                                    (context) => Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Padding(
                                                            padding: orientation ==
                                                                    Orientation.portrait
                                                                ? const EdgeInsets.symmetric(
                                                                    horizontal: 16.0)
                                                                : const EdgeInsets.symmetric(
                                                                    horizontal: 64.0),
                                                            child: Container(
                                                              height: orientation ==
                                                                      Orientation.portrait
                                                                  ? MediaQuery.of(context)
                                                                          .size
                                                                          .height *
                                                                      1 /
                                                                      2
                                                                  : MediaQuery.of(context)
                                                                      .size
                                                                      .height,
                                                              width: MediaQuery.of(context)
                                                                  .size
                                                                  .width,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(12.0),
                                                                        topLeft: Radius.circular(
                                                                            12.0)),
                                                                color: Theme.of(context)
                                                                    .colorScheme
                                                                    .background,
                                                              ),
                                                              child: const ShowTextTafseer(),
                                                            ),
                                                          ),
                                                        ),
                                                    elevation: 100);
                                              }
                                              // quranTextTafseer(context, TPageScaffoldKey,
                                              //     MediaQuery.of(context).size.width);
                                              cancel();
                                            },
                                          );
                                        } else {
                                          return Center(
                                              child: Lottie.asset('assets/lottie/search.json',
                                                  width: 100, height: 40));
                                        }
                                      }),
                                ),
                                SizedBox(
                                  width:  MySiezes.icon/2
                                ),
*/

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
          List<Ayah> ayahsList = await HttpService.downloadSurah(surahNumber: ayah.surahNumber);
          _quranCtr.selectedPage.startAyahNum.value = ayah.ayahNumber;
          _quranCtr.changeOnShownState(false);
          _audioCtr.stopAudio();
          if (_httpCtr.downloadProgress.value == 100) {
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
