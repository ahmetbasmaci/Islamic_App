import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/components/my_end_drawer.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_body_images.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_body_text.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_footer.dart';
import 'package:zad_almumin/pages/quran/components/quran_page_up.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../home/home_page.dart';
import 'controllers/quran/quran_page_ctr.dart';

class QuranPage extends StatefulWidget {
  QuranPage({Key? key, bool? showInKahf}) : super(key: key) {
    Get.find<QuranPageCtr>().showInKahf = showInKahf ?? false;
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

    _quranCtr.changeOnShownState(false);

    _quranCtr.tabCtr.addListener(() => _quranCtr.updateCurrentPageCtr());

    JsonService.loadQuranData();
  }

  @override
  Widget build(BuildContext context) {
    // _quranCtr.updateCurrentPageCtr();
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
        key: AppSettings.scaffoldKey,
        endDrawer: MyEndDrawer(),
        body: Stack(
          children: [
            SafeArea(
              child: SizedBox(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DefaultTabController(
                    length: 604,
                    child: TabBarView(
                      controller: _quranCtr.tabCtr,
                      children: quranBodys(),
                    ),
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
                duration: Duration(milliseconds: 600),
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

  Widget isBannerWidget({required bool isMarked, required Widget child}) {
    Widget parent = Container(child: child);
    if (isMarked) parent = Banner(message: '', location: BannerLocation.bottomStart, child: child);
    return parent;
  }
}
