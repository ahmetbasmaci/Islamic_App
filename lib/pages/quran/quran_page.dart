import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/pages/quran/classes/quran_helper.dart';
import 'package:zad_almumin/pages/quran/components/quran_down_part.dart';
import 'package:zad_almumin/pages/quran/components/quran_up_part.dart';
import 'package:zad_almumin/services/audio_service.dart';
import 'package:zad_almumin/services/http_service.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../home_page.dart';

import 'controllers/quran_page_ctr.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key, bool? showInKahf}) : super(key: key);
  static const String id = 'QuranPage';
  @override
  State<QuranPage> createState() => _QuranPageState();
  final bool showInKahf = false;
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  late TabController tabCtr;
  late AudioService audioService;
  late AnimationController animationCtr;
  int animationDurationMilliseconds = 600;
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
  Map quranMap = {};

  @override
  void initState() {
    super.initState();

    Constants.setNewOpendPageId(QuranPage.id);

    quranCtr.quranPageSetState = (() => setState(() {}));

    setCurrentPage();

    updateCurrentPageCtr();

    QuranHelper().changeOnShownState(false);

    tabCtr.addListener(() => updateCurrentPageCtr());
    animationCtr = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    audioService = AudioService(onPause: () => animationCtr.reverse());

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
        drawer: MyDrawer(),
        body: Stack(
          children: [
            DefaultTabController(
              length: 604,
              child: TabBarView(
                controller: tabCtr,
                children: [for (var i = 1; i <= 604; i++) quranPage(index: i)],
              ),
            ),
            // upPart(),
            QuranUpPart(quranPageSetState: (() => setState(() {}))),
            // downPart()
            QuranDownPart(animationCtr: animationCtr, audioService: audioService),
          ],
        ),
      ),
    );
  }

  setCurrentPage() {
    tabCtr = TabController(length: 604, vsync: this);
    quranCtr.tabCtr = tabCtr;

    //check last opend page
    tabCtr.index = GetStorage().read('pageIndex') ?? 0;

    //check if user open quran page from kahf notification
    if (widget.showInKahf) tabCtr.index = 294;
    quranCtr.selectedSurah.pageNumber.value = tabCtr.index + 1;
  }

  updateCurrentPageCtr() async {
    GetStorage().write('pageIndex', tabCtr.index);

    quranCtr.selectedSurah.pageNumber.value = tabCtr.index + 1;
    quranCtr.selectedSurah.juz.value = QuranHelper().getJuzNumberByPage(quranCtr.selectedSurah.pageNumber.value);
    String newSurahName = QuranHelper().getSurahNameByPage(quranCtr.selectedSurah.pageNumber.value);
    if (quranCtr.selectedSurah.surahName.value != newSurahName) {
      quranCtr.selectedSurah.surahName.value = newSurahName;
      quranCtr.selectedSurah.surahNumber.value =
          QuranHelper().getSurahNumberByName(quranCtr.selectedSurah.surahName.value);
      quranMap = await JsonService.getAllQuranData(quranCtr.selectedSurah.surahNumber.value);
      quranCtr.selectedSurah.totalAyahsNum.value = quranMap['numberOfAyahs'];
      quranCtr.selectedSurah.startAyahNum.value = 1;
      quranCtr.selectedSurah.endAyahNum.value = quranCtr.selectedSurah.totalAyahsNum.value;
    }
  }

/*
  Widget downPart() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      bottom: quranCtr.onShown.value ? 0 : -_downPartHeight,
      child: AnimatedContainer(
          duration: Duration(milliseconds: animationDurationMilliseconds),
          height: _downPartHeight,
          width: Get.size.width,
          decoration: BoxDecoration(
            color: MyColors.quranBackGround(),
            boxShadow: [
              BoxShadow(
                  color: MyColors.whiteBlack().withOpacity(0.2), offset: Offset(0, 5), blurRadius: 30, spreadRadius: .5)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MyTexts.quranSecondTitle(title: QuranHelper().getSurahNameByPage(quranCtr.pageNumber.value)),
                    MyTexts.quranSecondTitle(title: quranCtr.pageNumber.value.toString()),
                    MyTexts.quranSecondTitle(title: 'الجزء ${quranCtr.juz}'),
                  ],
                ),
              ),
              Obx(
                () => FutureBuilder(
                    future: updateSurahAyahsNumber(),
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting)
                        return DropdownButton<int>(
                            value: quranCtr.ayahStartNum.value, onChanged: (value) {}, items: []);

                      if (quranCtr.ayahStartNum.value > quranCtr.totalAyahsCount.value) quranCtr.ayahStartNum.value = 1;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          selectStartEndAyah(true),
                          AnimatedContainer(
                            duration: Duration(milliseconds: animationDurationMilliseconds),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: MyColors.quranBackGround(),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                // BoxShadow(color: MyColors.quranSecond().withOpacity(0.2), blurRadius: 30, spreadRadius: 10),
                              ],
                            ),
                            child: Obx(
                              () => DropdownButton<QuranReaders>(
                                value: quranCtr.selectedQuranReader.value,
                                onChanged: (newVal) {
                                  quranCtr.selectedQuranReader.value = newVal!;
                                  GetStorage().write('selectedQuranReader', quranCtr.selectedQuranReader.value.index);
                                },
                                items: [
                                  for (QuranReaders item in QuranReaders.values)
                                    DropdownMenuItem(
                                      value: item,
                                      child: MyTexts.quranSecondTitle(title: item.arabicName),
                                    )
                                ],
                              ),
                            ),
                          ),
                          selectStartEndAyah(false),
                        ],
                      );
                    }),
              ),
              Obx(
                () => AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: Get.find<HttpServiceCtr>().isLoading.value ? 1 : 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    // height: 30,
                    height: Get.find<HttpServiceCtr>().isLoading.value ? 30 : 0,
                    width: double.maxFinite,
                    decoration: BoxDecoration(boxShadow: []),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: LinearProgressIndicator(
                            value: Get.find<HttpServiceCtr>().received.value,
                            backgroundColor: Colors.grey,
                            color: MyColors.quranSecond(),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyTexts.quranSecondTitle(
                                title:
                                    '${Get.find<HttpServiceCtr>().downloadingIndex}/${Get.find<HttpServiceCtr>().totalAyahsDownload}'),
                            IconButton(
                              onPressed: () {
                                Get.find<HttpServiceCtr>().isStopDownload.value = true;
                                Get.find<HttpServiceCtr>().isLoading.value = false;
                                // animationCtr.reverse();
                              },
                              icon: MyIcons.close(color: MyColors.quranSecond()),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: MyIcons.repeat(color: MyColors.quranSecond()),
                    onPressed: () async {},
                  ),
                  IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: animationCtr,
                      size: 25,
                      color: MyColors.quranSecond(),
                    ),
                    onPressed: () async {
                      if (animationCtr.isDismissed) {
                        playAudio();
                      } else {
                        animationCtr.reverse();
                        AudioService().pauseAudio();
                      }
                    },
                  ),
                  IconButton(
                    icon: MyIcons.stop(color: MyColors.quranSecond()),
                    onPressed: () async {
                      animationCtr.reverse();
                      AudioService().stopAudio();
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget selectStartEndAyah(bool isStartAyah) {
    return Row(
      children: [
        MyTexts.quranSecondTitle(title: isStartAyah ? 'من الاية:  ' : 'الى الاية:  '),
        SizedBox(
          width: 80,
          child: Obx(() => MaterialButton(
                shape: Border.all(color: MyColors.quranSecond()),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: MyTexts.quranSecondTitle(title: 'اختر الاية:  '),
                      content: SizedBox(
                        height: 400,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getSurahAyahsList(isStartAyah),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MyTexts.content(
                        title: isStartAyah
                            ? quranCtr.ayahStartNum.value.toString()
                            : quranCtr.ayahEndNum.value.toString()),
                    Icon(Icons.keyboard_arrow_down, color: MyColors.quranSecond()),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  playAudio() async {
    animationCtr.forward();
    int surahNumber = QuranHelper().getSurahNumberByName(QuranHelper().getSurahNameByPage(quranCtr.pageNumber.value));
    List<Ayah> ayahsFileList = await HttpService.getSurah(surahNumber: surahNumber);
    audioService.playSurahAudio(ayahsFileList);
  }

  List<Widget> getSurahAyahsList(bool isStartNum) {
    List<Widget> list = [];
    int startFrom = isStartNum ? 1 : quranCtr.ayahStartNum.value;

    for (var i = startFrom; i <= quranCtr.totalAyahsCount.value; i++) {
      String ayah = '';
      if (quranMap.isNotEmpty) ayah = quranMap['ayahs'][i - 1]['text'].toString();

      list.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          color: isStartNum
              ? i == quranCtr.ayahStartNum.value
                  ? MyColors.quranSecond().withOpacity(.4)
                  : Colors.transparent
              : i == quranCtr.ayahEndNum.value
                  ? MyColors.quranSecond().withOpacity(.4)
                  : Colors.transparent,
          child: MaterialButton(
            onPressed: () {
              if (isStartNum)
                quranCtr.ayahStartNum.value = i;
              else
                quranCtr.ayahEndNum.value = i;
              Get.back();
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: MyTexts.quran(
                  title: '$i - ${ayah.replaceAll("\n", " ")}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right),
            ),
          ),
        ),
      );
    }

    return list;
  }


*/

  /*
  Widget upPart() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: quranCtr.onShown.value ? 0 : -_upPartHeight,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          height: _upPartHeight,
          width: Get.size.width,
          decoration: BoxDecoration(
            color: MyColors.quranBackGround(),
            boxShadow: [
              BoxShadow(
                  color: MyColors.whiteBlack().withOpacity(0.2), offset: Offset(0, 5), blurRadius: 30, spreadRadius: .5)
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Get.offAll(() => HomePage()),
                    icon: MyIcons.home(color: MyColors.quranSecond()),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    MyTexts.quranSecondTitle(title: 'الصفحة:   '),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: goToPageTextCtr,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        cursorHeight: 20,
                        showCursor: false,
                        onSubmitted: (val) {
                          goToPageTextCtr.clear();
                          changeOnShownState(false);
                        },
                        onTap: () => goToPageTextCtr.clear(),
                        onChanged: (val) {
                          if (goToPageTextCtr.text == '') return;
                          if (int.parse(goToPageTextCtr.text) > 604 || int.parse(goToPageTextCtr.text) < 1) {
                            Fluttertoast.showToast(msg: 'صفحة غير موجودة');
                            return;
                          }
                          tabCtr.index = int.parse(goToPageTextCtr.text) - 1;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => showMarkDialog(),
                      icon: MyIcons.mark(color: MyColors.quranSecond()),
                    ),
                    IconButton(
                      onPressed: () {
                        bool isDark = ThemeService().getThemeMode() == ThemeMode.dark;
                        ThemeService().changeThemeMode(!isDark);
                        setState(() {});
                      },
                      icon: MyIcons.animated_Light_Dark(color: MyColors.quranSecond()),
                    ),
                    IconButton(
                      onPressed: () => _key.currentState!.openEndDrawer(),
                      icon: MyIcons.book(color: MyColors.quranSecond()),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  showMarkDialog() {
    var pageProp = MarkedPage(
      pageNumber: quranCtr.pageNumber.value,
      juz: QuranHelper().getJuzNumberByPage(quranCtr.pageNumber.value),
      surahName: QuranHelper().getSurahNameByPage(quranCtr.pageNumber.value),
      isMarked: false,
    );
    for (var element in quranCtr.markedList)
      if (element.pageNumber == pageProp.pageNumber) if (element.isMarked) {
        pageProp.isMarked = true;
        break;
      }
    String title = pageProp.isMarked ? 'ازالة علامة قراءة' : 'اضافة علامة قراءة';
    String content =
        pageProp.isMarked ? 'هل تود ازالة علامة القراءة على هذه الصفحة؟' : 'هل تود وضع علامة على هذه الصفحة؟';

    return Get.dialog(
      AlertDialog(
        title: Text(title, style: TextStyle(color: MyColors.quranText())),
        content: Text(content, style: TextStyle(color: MyColors.quranText())),
        actionsAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: MyColors.quranBackGround(),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('الغاء'),
          ),
          TextButton(
            onPressed: () {
              if (pageProp.isMarked) {
                quranCtr.markedList.removeWhere((element) => element.pageNumber == pageProp.pageNumber);
                Fluttertoast.showToast(msg: 'تم ازالة العلامة');
              } else {
                pageProp.isMarked = true;
                quranCtr.markedList.add(pageProp);
                quranCtr.updateDb(pageProp);
                Fluttertoast.showToast(msg: 'تم اضافة العلامة');
              }
              Get.back();
              setState(() {});
            },
            child: Text('تأكيد'),
          ),
        ],
      ),
      transitionDuration: Duration(milliseconds: 500),
    );
  }
 

  void changeOnShownState(bool value) {
    if (value)
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      FocusManager.instance.primaryFocus?.unfocus();
    }

    quranCtr.onShown.value = value;
    setState(() {});
  }

 */
  Widget myEndDrawer() {
    quranCtr.markedList.sort((a, b) => a.pageNumber.compareTo(b.pageNumber));
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
                    border: Border(bottom: BorderSide(color: MyColors.quranSecond())),
                    boxShadow: [
                      BoxShadow(
                          color: MyColors.quranSecond().withOpacity(0.5),
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
                  itemCount: quranCtr.markedList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: index != quranCtr.markedList.length - 1 ? 10 : 0),
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
      title: MyTexts.settingsTitle(title: 'الجزء ${quranCtr.markedList[index].juz}'),
      subtitle: MyTexts.settingsContent(
          title: '${quranCtr.markedList[index].surahName}  |  الصفحة ${quranCtr.markedList[index].pageNumber}'),
      shape: Border(bottom: BorderSide(color: MyColors.quranSecond())),
      onTap: () {
        tabCtr.index = quranCtr.markedList[index].pageNumber - 1;
        QuranHelper().changeOnShownState(false);
        Get.back();
        // setState(() {});
      },
    );
  }

  Widget quranPage({required int index}) {
    bool isMarked = false;
    for (var element in quranCtr.markedList)
      if (element.pageNumber == index) if (element.isMarked) {
        isMarked = true;
        break;
      }

    return isBannerWidget(
      isMarked: isMarked,
      child: InkWell(
        onTap: () => QuranHelper().changeOnShownState(!quranCtr.onShown.value),
        onLongPress: () => QuranHelper().showMarkDialog(),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          color: MyColors.quranBackGround(),
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/quran pages/00$index.png',
                  // height: MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.height * .9,
                  color: MyColors.quranText(),
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/quran pages/000$index.png',
                  // height: MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.height * .9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget isBannerWidget({required bool isMarked, required Widget child}) {
    Widget parent = Container(child: child);
    if (isMarked) parent = Banner(message: '', location: BannerLocation.bottomStart, child: child);
    return parent;
  }
}
