import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/services/audio_service.dart';
import 'package:zad_almumin/services/http_service.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../../services/theme_service.dart';
import '../home_page.dart';
import 'classes/page_prop.dart';
import 'classes/ayah.dart';
import 'controllers/quran_page_ctr.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);
  static const String id = 'QuranPage';
  @override
  State<QuranPage> createState() => _QuranPageState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key to can open drawer

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  var goToPageCtr = TextEditingController();
  late TabController tabCtr;
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
  late AnimationController animationCtr;
  final double _downPartHeight = 170;
  final double _upPartHeight = 70;
  double screenW = 0;
  int animationDurationMilliseconds = 600;
  Map<String, dynamic> quranMap = {};
  late AudioService audioService;

  @override
  void initState() {
    super.initState();
    tabCtr = TabController(length: 604, vsync: this);
    tabCtr.index = GetStorage().read('pageIndex') ?? 0;

    quranCtr.pageNumber.value = tabCtr.index + 1;

    animationCtr = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    updateCurrentPage();

    changeOnShownState(false);
    tabCtr.addListener(() {
      updateCurrentPage();
    });

    audioService = AudioService(onPause: () {
      animationCtr.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        Get.offAll(HomePage());
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _key,
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
            upPart(),
            downPart()
          ],
        ),
      ),
    );
  }

  updateCurrentPage() async {
    quranCtr.pageNumber.value = tabCtr.index + 1;
    quranCtr.juz.value = getJuzNumberByPage(page: tabCtr.index + 1);
    quranCtr.surahName.value = getSurahNameByPage(page: tabCtr.index + 1);

    updateSurahAyahsNumber();
    GetStorage().write('pageIndex', tabCtr.index);

    quranMap = await JsonService.readQuranJson(getSurahNumberByName(quranCtr.surahName.value));
  }

  Widget downPart() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      bottom: quranCtr.onShown.value ? 0 : -_downPartHeight,
      child: AnimatedContainer(
          duration: Duration(milliseconds: animationDurationMilliseconds),
          height: _downPartHeight,
          width: screenW,
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
                    MyTexts.quranSecondTitle( title: getSurahNameByPage(page: quranCtr.pageNumber.value)),
                    MyTexts.quranSecondTitle( title: quranCtr.pageNumber.value.toString()),
                    MyTexts.quranSecondTitle( title: 'الجزء ${quranCtr.juz}'),
                  ],
                ),
              ),
              FutureBuilder(
                  future: updateSurahAyahsNumber(),
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting)
                      return DropdownButton<int>(value: quranCtr.ayahStartNum.value, onChanged: (value) {}, items: []);

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
                                    child: MyTexts.quranSecondTitle( title: item.arabicName),
                                  )
                              ],
                            ),
                          ),
                        ),
                        selectStartEndAyah(false),
                      ],
                    );
                  }),
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
        MyTexts.quranSecondTitle( title: isStartAyah ? 'من الاية:  ' : 'الى الاية:  '),
        Obx(
          () => SizedBox(
              width: 80,
              child: MaterialButton(
                shape: Border.all(color: MyColors.quranSecond()),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: MyTexts.quranSecondTitle( title: 'اختر الاية:  '),
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
    int surahNumber = getSurahNumberByName(getSurahNameByPage());
    List<Ayah> ayahsFileList = await HttpService.getSurah(surahNumber: surahNumber);
    audioService.playSurahAudio(ayahsFileList);
  }

  updateSurahAyahsNumber() async {
    int surahNumber = getSurahNumberByName(getSurahNameByPage());
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/database/quran/surahs/$surahNumber.json');
    Map data = jsonDecode(jsonString);

    quranCtr.totalAyahsCount.value = data['numberOfAyahs'];
    quranCtr.ayahStartNum = 1.obs;
    quranCtr.ayahEndNum = quranCtr.totalAyahsCount.value.obs;
  }

  List<Widget> getSurahAyahsList(bool isStartNum) {
    List<Widget> list = [];
    int startFrom = isStartNum ? 1 : quranCtr.ayahStartNum.value;
    for (var i = startFrom; i <= quranCtr.totalAyahsCount.value; i++) {
      String ayah = '';
      if (quranMap.isNotEmpty) ayah = quranMap['ayahs'][i - 1]['text'].toString();

      list.add(MaterialButton(
        onPressed: () {
          if (isStartNum)
            quranCtr.ayahStartNum.value = i;
          else
            quranCtr.ayahEndNum.value = i;
          Get.back();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          color: isStartNum
              ? i == quranCtr.ayahStartNum.value
                  ? MyColors.quranSecond().withOpacity(.4)
                  : Colors.transparent
              : i == quranCtr.ayahEndNum.value
                  ? MyColors.quranSecond().withOpacity(.4)
                  : Colors.transparent,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              '$i -$ayah',
              textAlign: TextAlign.start,
              style: GoogleFonts.harmattan(
                fontSize: 16,
                height: 2.2,
                fontWeight: FontWeight.w300,
                wordSpacing: 3.5,
              ),
            ),
            // child: MyTexts.content(context, title: '$i -$ayah'),
          ),
        ),
      ));
    }

    return list;
  }

  Widget upPart() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: quranCtr.onShown.value ? 0 : -_upPartHeight,
      child: AnimatedContainer(
          duration: Duration(milliseconds: animationDurationMilliseconds),
          height: _upPartHeight,
          width: screenW,
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
                    MyTexts.quranSecondTitle( title: 'الصفحة:   '),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: goToPageCtr,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        cursorHeight: 20,
                        showCursor: false,
                        onSubmitted: (val) {
                          goToPageCtr.clear();
                          changeOnShownState(false);
                        },
                        onTap: () => goToPageCtr.clear(),
                        onChanged: (val) {
                          if (goToPageCtr.text == '') return;
                          if (int.parse(goToPageCtr.text) > 604 || int.parse(goToPageCtr.text) < 1) {
                            Fluttertoast.showToast(msg: 'صفحة غير موجودة');
                            return;
                          }
                          tabCtr.index = int.parse(goToPageCtr.text) - 1;
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

  Widget myEndDrawer() {
    quranCtr.markedList.sort((a, b) => a.pageNumber.compareTo(b.pageNumber));
    return Drawer(
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
              child: MyTexts.quranSecondTitle( title: 'الملاحظات')),
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
    );
  }

  Widget markedListTile(int index) {
    return ListTile(
      title: MyTexts.settingsTitle( title: 'الجزء ${quranCtr.markedList[index].juz}'),
      subtitle: MyTexts.settingsContent(
          title: '${quranCtr.markedList[index].surahName}  |  الصفحة ${quranCtr.markedList[index].pageNumber}'),
      shape: Border(bottom: BorderSide(color: MyColors.quranSecond())),
      onTap: () {
        tabCtr.index = quranCtr.markedList[index].pageNumber - 1;
        changeOnShownState(false);
        Get.back();
        goToPageCtr.text = '${quranCtr.markedList[index].pageNumber}';
        setState(() {});
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
        onTap: () => changeOnShownState(!quranCtr.onShown.value),
        onLongPress: () => showMarkDialog(),
        child: AnimatedContainer(
          duration: Duration(milliseconds: animationDurationMilliseconds),
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

  Widget isBannerWidget({required bool isMarked, required Widget child}) {
    Widget parent = Container(child: child);
    if (isMarked) parent = Banner(message: '', location: BannerLocation.bottomStart, child: child);
    return parent;
  }

  showMarkDialog() {
    var pageProp = PageProp(
        pageNumber: tabCtr.index + 1, juz: getJuzNumberByPage(), surahName: getSurahNameByPage(), isMarked: false);
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

  int getSurahNumberByName(String surahName) {
    int number = 1;

    if (surahName == 'الفاتحة') number = 1;
    if (surahName == 'البقرة') number = 2;
    if (surahName == 'آل عمران') number = 3;
    if (surahName == 'النساء') number = 4;
    if (surahName == 'المائدة') number = 5;
    if (surahName == 'الانعام') number = 6;
    if (surahName == 'الأعراف') number = 7;
    if (surahName == 'الأنفال') number = 8;
    if (surahName == 'التوبة') number = 9;
    if (surahName == 'يونس') number = 10;
    if (surahName == 'هود') number = 11;
    if (surahName == 'يوسف') number = 12;
    if (surahName == 'الرعد') number = 13;
    if (surahName == 'إبراهيم') number = 14;
    if (surahName == 'الحجر') number = 15;
    if (surahName == 'النحل') number = 16;
    if (surahName == 'الإسراء') number = 17;
    if (surahName == 'الكهف') number = 18;
    if (surahName == 'مريم') number = 19;
    if (surahName == 'طه') number = 20;
    if (surahName == 'الأنبياء') number = 21;
    if (surahName == 'الحج') number = 22;
    if (surahName == 'المؤمنون') number = 23;
    if (surahName == 'النور') number = 24;
    if (surahName == 'الفرقان') number = 25;
    if (surahName == 'الشعراء') number = 26;
    if (surahName == 'النمل') number = 27;
    if (surahName == 'القصص') number = 28;
    if (surahName == 'العنكبوت') number = 29;
    if (surahName == 'الروم') number = 30;
    if (surahName == 'لقمان') number = 31;
    if (surahName == 'السجدة') number = 32;
    if (surahName == 'الأحزاب') number = 33;
    if (surahName == 'سبإ') number = 34;
    if (surahName == 'فاطر') number = 35;
    if (surahName == 'يس') number = 36;
    if (surahName == 'الصافات') number = 37;
    if (surahName == 'ص') number = 38;
    if (surahName == 'الزمر') number = 39;
    if (surahName == 'غافر') number = 40;
    if (surahName == 'فصلت') number = 41;
    if (surahName == 'الشورى') number = 42;
    if (surahName == 'الزخرف') number = 43;
    if (surahName == 'الدخان') number = 44;
    if (surahName == 'الجاثية') number = 45;
    if (surahName == 'الأحقاف') number = 46;
    if (surahName == 'محمد') number = 47;
    if (surahName == 'الفتح') number = 48;
    if (surahName == 'الحجرات') number = 49;
    if (surahName == 'ق') number = 50;
    if (surahName == 'الذاريات') number = 51;
    if (surahName == 'الطور') number = 52;
    if (surahName == 'النجم') number = 53;
    if (surahName == 'القمر') number = 54;
    if (surahName == 'الرحمن') number = 55;
    if (surahName == 'الواقعة') number = 56;
    if (surahName == 'الحديد') number = 57;
    if (surahName == 'المجادلة') number = 58;
    if (surahName == 'الحشر') number = 59;
    if (surahName == 'الممتحنة') number = 60;
    if (surahName == 'الصف') number = 61;
    if (surahName == 'الجمعة') number = 62;
    if (surahName == 'المنافقون') number = 63;
    if (surahName == 'التغابن') number = 64;
    if (surahName == 'الطلاق') number = 65;
    if (surahName == 'التحريم') number = 66;
    if (surahName == 'الملك') number = 67;
    if (surahName == 'القلم') number = 68;
    if (surahName == 'الحاقة') number = 69;
    if (surahName == 'المعارج') number = 70;
    if (surahName == 'نوح') number = 71;
    if (surahName == 'الجن') number = 72;
    if (surahName == 'المزمل') number = 73;
    if (surahName == 'المدثر') number = 74;
    if (surahName == 'القيامة') number = 75;
    if (surahName == 'الإنسان') number = 76;
    if (surahName == 'المرسلات') number = 77;
    if (surahName == 'النبإ') number = 78;
    if (surahName == 'النازعات') number = 79;
    if (surahName == 'عبس') number = 80;
    if (surahName == 'التكوير') number = 81;
    if (surahName == 'الإنفطار') number = 82;
    if (surahName == 'المطفّفين') number = 83;
    if (surahName == 'الإنشقاق') number = 84;
    if (surahName == 'البروج') number = 85;
    if (surahName == 'الطارق') number = 86;
    if (surahName == 'الأعلى') number = 87;
    if (surahName == 'الغاشية') number = 88;
    if (surahName == 'الفجر') number = 89;
    if (surahName == 'البلد') number = 90;
    if (surahName == 'الشمس') number = 91;
    if (surahName == 'الليل') number = 92;
    if (surahName == 'الضحى') number = 93;
    if (surahName == 'الشرح') number = 94;
    if (surahName == 'التين') number = 95;
    if (surahName == 'العلق') number = 96;
    if (surahName == 'القدر') number = 97;
    if (surahName == 'البينة') number = 98;
    if (surahName == 'الزلزلة') number = 99;
    if (surahName == 'العاديات') number = 100;
    if (surahName == 'القارعة') number = 101;
    if (surahName == 'التكاثر') number = 102;
    if (surahName == 'العصر') number = 103;
    if (surahName == 'الهمزة') number = 104;
    if (surahName == 'الفيل') number = 105;
    if (surahName == 'قريش') number = 106;
    if (surahName == 'الماعون') number = 107;
    if (surahName == 'الكوثر') number = 108;
    if (surahName == 'الكافرون') number = 109;
    if (surahName == 'النصر') number = 110;
    if (surahName == 'المسد') number = 111;
    if (surahName == 'الإخلاص') number = 112;
    if (surahName == 'الفلق') number = 113;
    if (surahName == 'الناس') number = 114;
    return number;
  }

  int getJuzNumberByPage({int? page}) {
    int juz = 1;
    page ??= tabCtr.index;
    if (page <= 21)
      juz = 1;
    else if (page <= 41)
      juz = 2;
    else if (page <= 61)
      juz = 3;
    else if (page <= 81)
      juz = 4;
    else if (page <= 101)
      juz = 5;
    else if (page <= 121)
      juz = 6;
    else if (page <= 141)
      juz = 7;
    else if (page <= 161)
      juz = 8;
    else if (page <= 181)
      juz = 9;
    else if (page <= 201)
      juz = 10;
    else if (page <= 221)
      juz = 11;
    else if (page <= 241)
      juz = 12;
    else if (page <= 261)
      juz = 13;
    else if (page <= 281)
      juz = 14;
    else if (page <= 301)
      juz = 15;
    else if (page <= 321)
      juz = 16;
    else if (page <= 341)
      juz = 17;
    else if (page <= 361)
      juz = 18;
    else if (page <= 381)
      juz = 19;
    else if (page <= 401)
      juz = 20;
    else if (page <= 421)
      juz = 21;
    else if (page <= 441)
      juz = 22;
    else if (page <= 461)
      juz = 23;
    else if (page <= 481)
      juz = 24;
    else if (page <= 501)
      juz = 25;
    else if (page <= 521)
      juz = 26;
    else if (page <= 541)
      juz = 27;
    else if (page <= 561)
      juz = 28;
    else if (page <= 581)
      juz = 29;
    else
      juz = 30;
    return juz;
  }

  String getSurahNameByPage({int? page}) {
    String surahName = '';
    page ??= tabCtr.index + 1;
    if (page == 1)
      surahName = 'الفاتحة';
    else if (page < 50)
      surahName = 'البقرة';
    else if (page < 77)
      surahName = 'آل عمران';
    else if (page < 106)
      surahName = 'النساء';
    else if (page < 128)
      surahName = 'المائدة';
    else if (page < 151)
      surahName = 'الأنعام';
    else if (page < 177)
      surahName = 'الأعراف';
    else if (page < 187)
      surahName = 'الأنفال';
    else if (page < 208)
      surahName = 'التوبة';
    else if (page < 221)
      surahName = 'يونس';
    else if (page < 235)
      surahName = 'هود';
    else if (page < 249)
      surahName = 'يوسف';
    else if (page < 255)
      surahName = 'الرعد';
    else if (page < 262)
      surahName = 'إبراهيم';
    else if (page < 267)
      surahName = 'الحجر';
    else if (page < 282)
      surahName = 'النحل';
    else if (page < 293)
      surahName = 'الإسراء';
    else if (page < 305)
      surahName = 'الكهف';
    else if (page < 312)
      surahName = 'مريم';
    else if (page < 322)
      surahName = 'طه';
    else if (page < 332)
      surahName = 'الأنبياء';
    else if (page < 342)
      surahName = 'الحج';
    else if (page < 350)
      surahName = 'المؤمنون';
    else if (page < 359)
      surahName = 'النور';
    else if (page < 367)
      surahName = 'الفرقان';
    else if (page < 377)
      surahName = 'الشعراء';
    else if (page < 385)
      surahName = 'النمل';
    else if (page < 396)
      surahName = 'القصص';
    else if (page < 404)
      surahName = 'العنكبوت';
    else if (page < 411)
      surahName = 'الروم';
    else if (page < 415)
      surahName = 'لقمان';
    else if (page < 418)
      surahName = 'السجدة';
    else if (page <= 428)
      surahName = 'الأحزاب';
    else if (page < 434)
      surahName = 'سبإ';
    else if (page < 440)
      surahName = 'فاطر';
    else if (page < 446)
      surahName = 'يس';
    else if (page < 453)
      surahName = 'الصافات';
    else if (page < 458)
      surahName = 'ص';
    else if (page < 467)
      surahName = 'الزمر';
    else if (page < 477)
      surahName = 'غافر';
    else if (page < 483)
      surahName = 'فصلت';
    else if (page < 489)
      surahName = 'الشورى';
    else if (page < 496)
      surahName = 'الزخرف';
    else if (page < 499)
      surahName = 'الدخان';
    else if (page < 502)
      surahName = 'الجاثية';
    else if (page < 507)
      surahName = 'الأحقاف';
    else if (page < 511)
      surahName = 'محمد';
    else if (page < 515)
      surahName = 'الفتح';
    else if (page < 518)
      surahName = 'الحجرات';
    else if (page < 520)
      surahName = 'ق';
    else if (page < 523)
      surahName = 'الذاريات';
    else if (page < 526)
      surahName = 'الطور';
    else if (page < 528)
      surahName = 'النجم';
    else if (page < 531)
      surahName = 'القمر';
    else if (page < 534)
      surahName = 'الرحمن';
    else if (page < 537)
      surahName = 'الواقعة';
    else if (page < 542)
      surahName = 'الحديد';
    else if (page < 545)
      surahName = 'المجادلة';
    else if (page < 549)
      surahName = 'الحشر';
    else if (page < 551)
      surahName = 'الممتحنة';
    else if (page < 553)
      surahName = 'الصف';
    else if (page < 554)
      surahName = 'الجمعة';
    else if (page < 556)
      surahName = 'المنافقون';
    else if (page < 558)
      surahName = 'التغابن';
    else if (page < 560)
      surahName = 'الطلاق';
    else if (page < 562)
      surahName = 'التحريم';
    else if (page < 564)
      surahName = 'الملك';
    else if (page < 566)
      surahName = 'القلم';
    else if (page < 568)
      surahName = 'الحاقة';
    else if (page < 570)
      surahName = 'المعارج';
    else if (page < 572)
      surahName = 'نوح';
    else if (page < 574)
      surahName = 'الجن';
    else if (page < 575)
      surahName = 'المزمل';
    else if (page < 577)
      surahName = 'المدثر';
    else if (page < 578)
      surahName = 'القيامة';
    else if (page < 580)
      surahName = 'الإنسان';
    else if (page < 582)
      surahName = 'المرسلات';
    else if (page < 583)
      surahName = 'النبأ';
    else if (page < 585)
      surahName = 'النازعات';
    else if (page < 586)
      surahName = 'عبس';
    else if (page < 587)
      surahName = 'التكوير';
    else if (page < 587)
      surahName = 'الإنفطار';
    else if (page < 589)
      surahName = 'المطففين';
    else if (page < 590)
      surahName = 'الإنشقاق';
    else if (page < 591)
      surahName = 'البروج';
    else if (page < 591)
      surahName = 'الطارق';
    else if (page < 592)
      surahName = 'الأعلى';
    else if (page < 593)
      surahName = 'الغاشية';
    else if (page < 594)
      surahName = 'الفجر';
    else if (page < 595)
      surahName = 'البلد';
    else if (page < 595)
      surahName = 'الشمس';
    else if (page < 596)
      surahName = 'الليل';
    else if (page < 596)
      surahName = 'الضحى';
    else if (page < 597)
      surahName = 'الشرح';
    else if (page < 597)
      surahName = 'التين';
    else if (page < 598)
      surahName = 'العلق';
    else if (page < 598)
      surahName = 'القدر';
    else if (page < 599)
      surahName = 'البينة';
    else if (page <= 599)
      surahName = 'الزلزلة';
    else if (page < 600)
      surahName = 'العاديات';
    else if (page < 600)
      surahName = 'القارعة';
    else if (page < 601)
      surahName = 'التكاثر';
    else if (page < 601)
      surahName = 'العصر';
    else if (page < 601)
      surahName = 'الهمزة';
    else if (page < 602)
      surahName = 'الفيل';
    else if (page < 602)
      surahName = 'قريش';
    else if (page < 602)
      surahName = 'الماعون';
    else if (page < 603)
      surahName = 'الكوثر';
    else if (page < 603)
      surahName = 'الكافرون';
    else if (page < 603)
      surahName = 'النصر';
    else if (page < 604)
      surahName = 'المسد';
    else if (page < 604)
      surahName = 'الإخلاص';
    else if (page < 604)
      surahName = 'الناس';
    else
      surahName = 'الفلق';
    return surahName;
  }
}
