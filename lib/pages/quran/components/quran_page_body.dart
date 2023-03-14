import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/constents/sizes.dart';
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
    List<InlineSpan> text = [];
    List<List<Ayah>> ayahsInPage = _quranData.getAyahsInPage(page);
    double fontSizeArabic = 18;
    for (var surahAyahs in ayahsInPage) {
      for (var ayah in surahAyahs) {
        text.add(
          TextSpan(
            children: [
              TextSpan(
                  text: ayah.text,
                  style: TextStyle(
                    fontSize: fontSizeArabic,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'uthmanic2',
                    color: MyColors.quranText(),
                    background: Paint()
                      ..color = _quranCtr.selectedAyah.value.ayahNumber == ayah.ayahNumber &&
                              _quranCtr.selectedAyah.value.surahName == ayah.surahName
                          ? MyColors.quranPrimary().withOpacity(0.5)
                          : Colors.transparent
                      ..strokeJoin = StrokeJoin.round
                      ..strokeCap = StrokeCap.round
                      ..style = PaintingStyle.fill,
                  ),
                  recognizer: LongPressGestureRecognizer()
                    ..onLongPressStart = (details) {
                      //set selected ayah
                      _quranCtr.selectedAyah.value = ayah;

                      var cancel = BotToast.showAttachedWidget(
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
                                // Container(
                                //   color: Colors.red,
                                // ),
                                // Container(
                                //   height   MySiezes.icon*2,
                                //   decoration: BoxD:  MySiezes.icon*2,
                                //   width:ecoration(
                                //       color: Color(0xfff3efdf),
                                //       borderRadius: BorderRadius.all(Radius.circular(50))),
                                //   child: FutureBuilder<List<Ayat>>(
                                //       future: QuranCubit.get(context)
                                //           .handleRadioValueChanged(
                                //               QuranCubit.get(context).radioValue)
                                //           .getAyahTranslate((widget.surah!.number)),
                                //       builder: (context, snapshot) {
                                //         if (snapshot.connectionState == ConnectionState.done) {
                                //           List<Ayat>? ayat = snapshot.data;
                                //           Ayat aya = Ayat();
                                //           return IconButton(
                                //             icon: Icon(
                                //               Icons.text_snippet_outlined,
                                //               size:  MySiezes.icon,
                                //               color: MyColors.quranPrimary(),
                                //             ),
                                //             onPressed: () {
                                //               TextCubit.translateAyah = "${aya.ayatext}";
                                //               TextCubit.translate = "${aya.translate}";
                                //               // showModalBottomSheet<void>(
                                //               //   context: context,
                                //               //   builder: (BuildContext context) {
                                //               //     return ShowTextTafseer();
                                //               //   },
                                //               // );
                                //               if (TextCubit.isShowBottomSheet) {
                                //                 Navigator.pop(context);
                                //               } else {
                                //                 TPageScaffoldKey.currentState?.showBottomSheet(
                                //                     shape: const RoundedRectangleBorder(
                                //                         borderRadius: BorderRadius.only(
                                //                             topLeft: Radius.circular(8),
                                //                             topRight: Radius.circular(8))),
                                //                     backgroundColor: Colors.transparent,
                                //                     (context) => Align(
                                //                           alignment: Alignment.bottomCenter,
                                //                           child: Padding(
                                //                             padding: orientation ==
                                //                                     Orientation.portrait
                                //                                 ? const EdgeInsets.symmetric(
                                //                                     horizontal: 16.0)
                                //                                 : const EdgeInsets.symmetric(
                                //                                     horizontal: 64.0),
                                //                             child: Container(
                                //                               height: orientation ==
                                //                                       Orientation.portrait
                                //                                   ? MediaQuery.of(context)
                                //                                           .size
                                //                                           .height *
                                //                                       1 /
                                //                                       2
                                //                                   : MediaQuery.of(context)
                                //                                       .size
                                //                                       .height,
                                //                               width: MediaQuery.of(context)
                                //                                   .size
                                //                                   .width,
                                //                               decoration: BoxDecoration(
                                //                                 borderRadius:
                                //                                     const BorderRadius.only(
                                //                                         topRight:
                                //                                             Radius.circular(12.0),
                                //                                         topLeft: Radius.circular(
                                //                                             12.0)),
                                //                                 color: Theme.of(context)
                                //                                     .colorScheme
                                //                                     .background,
                                //                               ),
                                //                               child: const ShowTextTafseer(),
                                //                             ),
                                //                           ),
                                //                         ),
                                //                     elevation: 100);
                                //               }
                                //               // quranTextTafseer(context, TPageScaffoldKey,
                                //               //     MediaQuery.of(context).size.width);
                                //               cancel();
                                //             },
                                //           );
                                //         } else {
                                //           return Center(
                                //               child: Lottie.asset('assets/lottie/search.json',
                                //                   width: 100, height: 40));
                                //         }
                                //       }),
                                // ),
                                // SizedBox(
                                //   width:  MySiezes.icon/2
                                // ),
                                Container(
                                  height: MySiezes.icon * 2,
                                  width: MySiezes.icon * 2,
                                  decoration: BoxDecoration(
                                      color: MyColors.whiteBlackReversed(),
                                      borderRadius: BorderRadius.all(Radius.circular(50))),
                                  child: IconButton(
                                    icon: Icon(Icons.bookmark_border,
                                        size: MySiezes.icon, color: MyColors.quranPrimary()),
                                    onPressed: () {
                                      cancel();
                                    },
                                  ),
                                ),
                                SizedBox(width: MySiezes.icon / 2),
                                Container(
                                  height: MySiezes.icon * 2,
                                  width: MySiezes.icon * 2,
                                  decoration: BoxDecoration(
                                      color: MyColors.whiteBlackReversed(),
                                      borderRadius: BorderRadius.all(Radius.circular(50))),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.copy_outlined,
                                      size: MySiezes.icon,
                                      color: MyColors.quranPrimary(),
                                    ),
                                    onPressed: () {
                                      cancel();
                                    },
                                  ),
                                ),
                                SizedBox(width: MySiezes.icon / 2),
                                Container(
                                  height: MySiezes.icon * 2,
                                  decoration: BoxDecoration(
                                      color: MyColors.whiteBlackReversed(),
                                      borderRadius: BorderRadius.all(Radius.circular(50))),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.play_circle,
                                      size: MySiezes.icon,
                                      color: MyColors.quranPrimary(),
                                    ),
                                    onPressed: () async {
                                      cancel();
                                      List<Ayah> ayahsList = await HttpService.getSurah(
                                          surahNumber: _quranCtr.selectedSurah.surahNumber.value);
                                      _quranCtr.selectedSurah.startAyahNum.value = ayah.ayahNumber;
                                      _quranCtr.selectedAyah.value = Ayah.empty(); //to hide background color
                                      AudioCtr().playMultiAudio(ayahList: ayahsList);
                                    },
                                  ),
                                ),
                                SizedBox(width: MySiezes.icon / 2),
                                Container(
                                  height: MySiezes.icon * 2,
                                  width: MySiezes.icon * 2,
                                  decoration: BoxDecoration(
                                      color: MyColors.whiteBlackReversed(),
                                      borderRadius: BorderRadius.all(Radius.circular(50))),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.share_outlined,
                                      size: MySiezes.icon,
                                      color: MyColors.quranPrimary(),
                                    ),
                                    onPressed: () {
                                      cancel();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
            ],
          ),
        );
        text.add(
          TextSpan(children: [
            TextSpan(
              text: ' ${Constants.convertToArabicNumber(ayah.ayahNumber)} ',
              style: TextStyle(
                  fontSize: fontSizeArabic,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'uthmanic2',
                  color: MyColors.quranPrimary()),
            )
          ]),
        );
      }
    }
    pages.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: fontSizeArabic, backgroundColor: Colors.transparent, fontFamily: 'uthmanic2'),
              children: text.map((e) => e).toList(),
            ),
          ),
        ),
      ),
    );
    // SizedBox(
    //   height:Get.size.height,
    //   child: ScrollablePositionedList.builder(
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     addAutomaticKeepAlives: true,
    //     // itemScrollController: TextCubit.itemScrollController,
    //     // itemPositionsListener: TextCubit.itemPositionsListener,
    //     itemCount: (page),
    //     itemBuilder: (context, index) {

    //       return Stack(
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               TextCubit.controller.forward();
    //               setState(() {
    //                 backColor = Colors.transparent;
    //               });
    //             },
    //             child: Container(
    //               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    //               width: MediaQuery.of(context).size.width,
    //               decoration: BoxDecoration(
    //                   color: Theme.of(context).colorScheme.background,
    //                   borderRadius: const BorderRadius.all(Radius.circular(8))),
    //               child: Column(
    //                 children: [
    //                   sorahName(
    //                     widget.surah!.number.toString(),
    //                     context,
    //                     ThemeProvider.themeOf(context).id == 'dark' ? Colors.white : Colors.black,
    //                   ),
    //                   Center(
    //                     child: SizedBox(
    //                         height: 50,
    //                         width: MediaQuery.of(context).size.width / 1 / 2,
    //                         child: SvgPicture.asset(
    //                           'assets/svg/space_line.svg',
    //                         )),
    //                   ),

    //                   Center(
    //                     child: SizedBox(
    //                         height: 50,
    //                         width: MediaQuery.of(context).size.width / 1 / 2,
    //                         child: SvgPicture.asset(
    //                           'assets/svg/space_line.svg',
    //                         )),
    //                   ),
    //                   Align(
    //                     alignment: Alignment.bottomCenter,
    //                     child: pageNumber(arabicNumber.convert(widget.nomPageF! + index).toString(),
    //                         context, Theme.of(context).primaryColor),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(32.0),
    //             child: Align(
    //               alignment: Alignment.topLeft,
    //               child: juzNum(
    //                 '$juz',
    //                 context,
    //                 ThemeProvider.themeOf(context).id == 'dark' ? Colors.white : Colors.black,
    //               ),
    //             ),
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // ),

    return pages;
  }
}
