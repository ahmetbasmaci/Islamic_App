import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/pages/quran/classes/quran_helper.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_body.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_footer.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_up.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
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

    JsonService.loadQuranData();
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
                children: quranBodys(),
              ),
            ),
            QuranPageUp(quranPageSetState: (() => setState(() {}))),
            QuranPageFooter(),
          ],
        ),
      ),
    );
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
      },
    );
  }

  List<Widget> quranBodys() {
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
              child: QuranPageBody(page: page),
            ),
          ),
        ),
      );
    }
    return quranPages;
  }

  Widget isBannerWidget({required bool isMarked, required Widget child}) {
    Widget parent = Container(child: child);
    if (isMarked) parent = Banner(message: '', location: BannerLocation.bottomStart, child: child);
    return parent;
  }
}
