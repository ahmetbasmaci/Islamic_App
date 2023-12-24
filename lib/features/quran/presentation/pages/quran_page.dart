import 'package:flutter/material.dart';

class QuranPage extends StatefulWidget {
  QuranPage({super.key, bool? showInKahf}) {
    // Get.find<QuranPageCtr>().showInKahf = showInKahf ?? false;
  }
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  int animationDurationMilliseconds = 600;
  // final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();

  @override
  void initState() {
    super.initState();

    // HelperMethods.setNewOpendPageId(QuranPage.id);

    // _quranCtr.quranPageSetState = (() => setState(() {}));

    // _quranCtr.setCurrentPage(this);

    // _quranCtr.changeOnShownState(false);

    // _quranCtr.tabCtr.addListener(() => _quranCtr.updateCurrentPageCtr());

    // JsonService.loadQuranData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      key: UniqueKey(),
      onPopInvoked: (didPop) async {
        //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        //_quranCtr.changeOnShownState(true);
        // Get.offAll(HomePage());
        // return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // key: AppSettings.scaffoldKey,
        //  endDrawer: MyEndDrawer(),
        body: Stack(
          children: [
            SafeArea(
              child: SizedBox(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DefaultTabController(
                    length: 604,
                    child: TabBarView(
                      //controller: _quranCtr.tabCtr,
                      children: [Container()], // quranBodys(),
                    ),
                  ),
                ),
              ),
            ),
            // QuranPageUp(quranPageSetState: (() => setState(() {}))),
            // QuranPageFooter(),
          ],
        ),
      ),
    );
  }

/*
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
          child: Obx(() {
            return InkWell(
              onTap: () => _quranCtr.pagePressed(),
              onLongPress: () => _quranCtr.showMarkDialog(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                color: MyColors.quranBackGround,
                child:
                    _quranCtr.showQuranImages.value ? QuranPageBodyImages(page: page) : QuranPageBodyTexts(page: page),
              ),
            );
          }),
        ),
      );
    }
    return quranPages;
  }
*/
  Widget isBannerWidget({required bool isMarked, required Widget child}) {
    Widget parent = Container(child: child);
    if (isMarked) parent = Banner(message: '', location: BannerLocation.bottomStart, child: child);
    return parent;
  }
}
