import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_body.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_footer.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_up.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../home_page.dart';
import 'controllers/quran_page_ctr.dart';

class QuranPage extends StatefulWidget {
  QuranPage({Key? key, bool? showInKahf}) : super(key: key) {
    Get.find<QuranPageCtr>().showInKahf = showInKahf??false;
  }
  static const String id = 'QuranPage';
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  int animationDurationMilliseconds = 600;
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();

  @override
  void initState() {
    super.initState();

    HelperMethods.setNewOpendPageId(QuranPage.id);

    _quranCtr.quranPageSetState = (() => setState(() {}));

    _quranCtr.setCurrentPage(this);

    _quranCtr.updateCurrentPageCtr();

    _quranCtr.changeOnShownState(false);

    _quranCtr.tabCtr.addListener(() => _quranCtr.updateCurrentPageCtr());

    JsonService.loadQuranData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      key: UniqueKey(),
      onWillPop: () async {
        //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        _quranCtr.changeOnShownState(true);
        Get.offAll(HomePage());
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: Constants.scaffoldKey,
        endDrawer: myEndDrawer(),
        body: Stack(
          children: [
            SafeArea(
              child: SizedBox(
                child: DefaultTabController(
                  length: 604,
                  child: TabBarView(
                    controller: _quranCtr.tabCtr,
                    children: quranBodys(),
                  ),
                ),
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
      onTap: () => _quranCtr.markedListBtnPress(index),
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
            onTap: ()=>_quranCtr.pagePressed(),
            onLongPress: () => _quranCtr.showMarkDialog(),
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
