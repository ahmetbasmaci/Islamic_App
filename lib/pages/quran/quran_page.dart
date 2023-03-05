import 'package:audio_manager/audio_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/pages/quran/classes/quran_helper.dart';
import 'package:zad_almumin/pages/quran/components/quran_down_part.dart';
import 'package:zad_almumin/pages/quran/components/quran_up_part.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/services/http_service.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../home_page.dart';
import 'controllers/quran_page_ctr.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key, bool? showInKahf, bool? isImages}) : super(key: key);
  static const String id = 'QuranPage';
  @override
  State<QuranPage> createState() => _QuranPageState();
  final bool showInKahf = false;
  final bool isAsImages = true;
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  late TabController tabCtr;
  late AnimationController animationCtr;
  int animationDurationMilliseconds = 600;
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  final QuranHelper _quranHelper = QuranHelper();
  final QuranData _quranData = Get.find<QuranData>();
  @override
  void initState() {
    super.initState();

    Constants.setNewOpendPageId(QuranPage.id);

    _quranCtr.quranPageSetState = (() => setState(() {}));

    setCurrentPage();

    updateCurrentPageCtr();

    _quranHelper.changeOnShownState(false);

    tabCtr.addListener(() => updateCurrentPageCtr());
    animationCtr = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    JsonService.loadQuranData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        Get.offAll(HomePage());
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: Constants.scaffoldKey,
        endDrawer: myEndDrawer(),
        body: Stack(
          children: [
            DefaultTabController(
              length: 604,
              child: TabBarView(
                controller: tabCtr,
                children: quranPages(isAsImages: false), //widget.isAsImages
              ),
            ),
            QuranUpPart(quranPageSetState: (() => setState(() {}))),
            QuranDownPart(animationCtr: animationCtr),
          ],
        ),
      ),
    );
  }

  setCurrentPage() {
    tabCtr = TabController(length: 604, vsync: this);
    _quranCtr.tabCtr = tabCtr;

    //check last opend page
    tabCtr.index = GetStorage().read('pageIndex') ?? 0;

    //check if user open quran page from kahf notification
    if (widget.showInKahf) tabCtr.index = 294;
    _quranCtr.selectedSurah.pageNumber.value = tabCtr.index + 1;
  }

  updateCurrentPageCtr() async {
    GetStorage().write('pageIndex', tabCtr.index);

    _quranCtr.selectedSurah.pageNumber.value = tabCtr.index + 1;
    _quranCtr.selectedSurah.juz.value = _quranData.getJuzNumberByPage(_quranCtr.selectedSurah.pageNumber.value);
    String newSurahName = _quranData.getSurahNameByPage(_quranCtr.selectedSurah.pageNumber.value);
    if (_quranCtr.selectedSurah.surahName.value != newSurahName) {
      _quranCtr.selectedSurah.surahName.value = newSurahName;
      _quranCtr.selectedSurah.surahNumber.value =
          _quranData.getSurahNumberByName(_quranCtr.selectedSurah.surahName.value);
      _quranCtr.selectedSurah.totalAyahsNum.value =
          _quranData.getSurahAyahs(_quranCtr.selectedSurah.surahNumber.value).length;
      _quranCtr.selectedSurah.startAyahNum.value = 1;
      _quranCtr.selectedSurah.endAyahNum.value = _quranCtr.selectedSurah.totalAyahsNum.value;
    }
  }

  Widget myEndDrawer() {
    _quranCtr.markedList.sort((a, b) => a.pageNumber.compareTo(b.pageNumber));
    return SafeArea(
      child: Drawer(
        backgroundColor: MyColors.quranBackGround(),
        width: 220,
        child: Column(
          children: [
            Container(
                height: 60,
                alignment: Alignment.center,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: MyColors.quranBackGround(),
                    border: Border(bottom: BorderSide(color: MyColors.quranPrimary())),
                    boxShadow: [
                      BoxShadow(
                          color: MyColors.quranPrimary().withOpacity(0.5),
                          offset: Offset(-5, 0),
                          blurRadius: 10,
                          spreadRadius: 5)
                    ]),
                child: MyTexts.quranSecondTitle(title: 'الملاحظات')),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: _quranCtr.markedList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: index != _quranCtr.markedList.length - 1 ? 10 : 0),
                      child: markedListTile(index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget markedListTile(int index) {
    return ListTile(
      title: MyTexts.settingsTitle(title: 'الجزء ${_quranCtr.markedList[index].juz}'),
      subtitle: MyTexts.settingsContent(
          title: '${_quranCtr.markedList[index].surahName}  |  الصفحة ${_quranCtr.markedList[index].pageNumber}'),
      shape: Border(bottom: BorderSide(color: MyColors.quranPrimary())),
      onTap: () {
        tabCtr.index = _quranCtr.markedList[index].pageNumber - 1;

        _quranHelper.changeOnShownState(false);
        Get.back();
        // setState(() {});
      },
    );
  }

  List<Widget> quranPages({required bool isAsImages}) {
    List<Widget> quranPages = [];
    bool isMarked = false;
    List<bool> markedPages = List.generate(605, (index) => false);
    for (var element in _quranCtr.markedList) {
      if (element.isMarked) markedPages[element.pageNumber] = true;
    }
    for (var page = 1; page <= 604; page++) {
      isMarked = markedPages[page];
      quranPages.add(
        isBannerWidget(
          isMarked: isMarked,
          child: InkWell(
            onTap: () {
              _quranHelper.changeOnShownState(!_quranCtr.onShown.value);
              _quranCtr.selectedAyah.value = Ayah.empty();
            },
            onLongPress: () => _quranHelper.showMarkDialog(),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 600),
              color: MyColors.quranBackGround(),
              child: Obx(
                () => Stack(
                  children: _quranCtr.selectedAyah.value.page != -1 && isAsImages
                      ? getQuranImages(page: page)
                      : getQuranTexts(page: page),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return quranPages;
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
                                      _quranCtr.selectedAyah.value = Ayah.empty();
                                      AudioCtr().playMultiAudio(ayahList: ayahsList, onStop: () {}, onStart: () {});
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

  Widget isBannerWidget({required bool isMarked, required Widget child}) {
    Widget parent = Container(child: child);
    if (isMarked) parent = Banner(message: '', location: BannerLocation.bottomStart, child: child);
    return parent;
  }
}
