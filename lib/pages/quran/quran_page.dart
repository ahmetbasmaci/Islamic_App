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
            QuranDownPart(animationCtr: animationCtr),
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
                  color: MyColors.quranText(),
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/quran pages/000$index.png',
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
