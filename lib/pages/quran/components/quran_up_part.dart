import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/pages/quran/classes/ayah.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../../../constents/colors.dart';
import '../../../constents/icons.dart';
import '../../../constents/texts.dart';
import '../../../services/theme_service.dart';
import '../../home_page.dart';
import '../classes/quran_helper.dart';
import '../classes/searched_ayah.dart';
import '../classes/surah.dart';
import '../controllers/quran_page_ctr.dart';

class QuranUpPart extends StatelessWidget {
  QuranUpPart({Key? key, required this.quranPageSetState}) : super(key: key);
  VoidCallback quranPageSetState;
  final double _upPartHeight = Get.size.height * .1;
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();

  var goToPageTextCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                          QuranHelper().changeOnShownState(false);
                        },
                        onTap: () => goToPageTextCtr.clear(),
                        onChanged: (val) {
                          if (goToPageTextCtr.text == '') return;
                          if (int.parse(goToPageTextCtr.text) > 604 || int.parse(goToPageTextCtr.text) < 1) {
                            Fluttertoast.showToast(msg: 'صفحة غير موجودة');
                            return;
                          }
                          quranCtr.tabCtr.index = int.parse(goToPageTextCtr.text) - 1;
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
                      onPressed: () => showSearch(context: context, delegate: SearchDel()),
                      icon: MyIcons.search(color: MyColors.quranSecond()),
                    ),
                    IconButton(
                      onPressed: () => QuranHelper().showMarkDialog(),
                      icon: MyIcons.mark(color: MyColors.quranSecond()),
                    ),
                    IconButton(
                      onPressed: () {
                        bool isDark = ThemeService().getThemeMode() == ThemeMode.dark;
                        ThemeService().changeThemeMode(!isDark);
                        quranPageSetState.call();
                      },
                      icon: MyIcons.animated_Light_Dark(color: MyColors.quranSecond()),
                    ),
                    IconButton(
                      onPressed: () => Constants.scaffoldKey.currentState!.openEndDrawer(),
                      icon: MyIcons.book(color: MyColors.quranSecond()),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class SearchDel extends SearchDelegate {
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();

  @override
  String get searchFieldLabel => 'بحث عن اية او سورة...';

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        scaffoldBackgroundColor: MyColors.quranBackGround(),
        iconTheme: IconThemeData(color: MyColors.quranSecond()),
        appBarTheme:
            AppBarTheme(color: MyColors.quranBackGround(), iconTheme: IconThemeData(color: MyColors.quranSecond())),
        textTheme: TextTheme(headline6: TextStyle(color: MyColors.quranSecond())),
        textSelectionTheme: TextSelectionThemeData(cursorColor: MyColors.quranSecond()),
        inputDecorationTheme: InputDecorationTheme(focusedBorder: InputBorder.none, border: InputBorder.none),
      );

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.arrow_forward), onPressed: () => close(context, null))];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(icon: Icon(Icons.close), onPressed: () => query = '');

  @override
  Widget buildResults(BuildContext context) => suggestions();

  @override
  Widget buildSuggestions(BuildContext context) => suggestions();

  Widget suggestions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            MyTexts.quranSecondTitle(title: 'السور', size: 19, fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            surahsSuggestionResult(),
            Divider(),
            SizedBox(height: 10),
            MyTexts.quranSecondTitle(title: 'الايات', size: 19, fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            ayahsSuggestionResult(),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget surahsSuggestionResult() {
    if (query == '') return Container();
    List<Surah> surahsResult = QuranHelper().getMatchedSurahs(query);
    return SizedBox(
      height: Get.size.height * .2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: ayahsResult.length,
            //   itemBuilder: (context, index) =>
            // ListTile(
            //     onTap: () {
            //       Get.back();
            //       quranCtr.tabCtr.index = ayahsResult[index].numberOfPage - 1;
            //     },
            //     title: MyTexts.quranSecondTitle(title: ayahsResult[index].name),
            //     trailing: MyTexts.quranSecondTitle(title: 'الصفحة: ${ayahsResult[index].numberOfPage}'),
            //   ),
            // ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 5 / 1.5),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: surahsResult.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  onTap: () {
                    Get.back();
                    quranCtr.tabCtr.index = surahsResult[index].numberOfPage - 1;
                  },
                  title: MyTexts.quranSecondTitle(title: surahsResult[index].name),
                  // trailing: MyTexts.quranSecondTitle(title: 'الصفحة: ${ayahsResult[index].numberOfPage}'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget ayahsSuggestionResult() {
    if (query == '') return Container();
    List<SearchedAyah> ayahsResult = QuranHelper().getMatchedAyahs(query);
    return SizedBox(
      height: Get.size.height * .2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: ayahsResult.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Get.back();
                  quranCtr.tabCtr.index = ayahsResult[index].numberOfPage - 1;
                },
                title: MyTexts.quran(
                    title: ayahsResult[index].ayahTxt, color: MyColors.quranSecond(), textAlign: TextAlign.right),
                trailing: MyTexts.quran(
                  title: ayahsResult[index].surahName.toString(),
                  color: MyColors.quranSecond(),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
