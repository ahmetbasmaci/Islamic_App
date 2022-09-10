import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/pages/quran/classes/filter_chip_prop.dart';

import '../../../constents/colors.dart';
import '../../../constents/texts.dart';
import '../../../moduls/enums.dart';
import '../classes/quran_helper.dart';
import '../classes/searched_ayah.dart';
import '../classes/surah.dart';
import '../controllers/quran_page_ctr.dart';
import 'draggable_filter_chip.dart';

class QuranSearchDelegate extends SearchDelegate {
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
      padding: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DraggableFilterChip(),
            SizedBox(height: MySiezes.screenPadding),
            searchSuggestionResultOrder(),
          ],
        ),
      ),
    );
  }

  searchSuggestionResultOrder() {
    List<Widget> orderedResult = [
      Obx(
        () => quranCtr.searchFilterList[0].value.isSelected.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: MyTexts.quranSecondTitle(
                        title: quranCtr.searchFilterList[0].value.text, size: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySiezes.screenPadding),
                  quranCtr.searchFilterList[0].value.searchFilter == SearchFilter.surah
                      ? surahsSuggestionResult()
                      : quranCtr.searchFilterList[0].value.searchFilter == SearchFilter.ayah
                          ? ayahsSuggestionResult()
                          : pagesSuggestionresult(),
                  Divider(),
                  SizedBox(height: MySiezes.screenPadding),
                ],
              )
            : Container(),
      ),
      Obx(
        () => quranCtr.searchFilterList[1].value.isSelected.value
            ? Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: MyTexts.quranSecondTitle(
                        title: quranCtr.searchFilterList[1].value.text, size: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySiezes.screenPadding),
                  quranCtr.searchFilterList[1].value.searchFilter == SearchFilter.surah
                      ? surahsSuggestionResult()
                      : quranCtr.searchFilterList[1].value.searchFilter == SearchFilter.ayah
                          ? ayahsSuggestionResult()
                          : pagesSuggestionresult(),
                  Divider(),
                  SizedBox(height: MySiezes.screenPadding),
                ],
              )
            : Container(),
      ),
      Obx(
        () => quranCtr.searchFilterList[2].value.isSelected.value
            ? Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: MyTexts.quranSecondTitle(
                        title: quranCtr.searchFilterList[2].value.text, size: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySiezes.screenPadding),
                  quranCtr.searchFilterList[2].value.searchFilter == SearchFilter.surah
                      ? surahsSuggestionResult()
                      : quranCtr.searchFilterList[2].value.searchFilter == SearchFilter.ayah
                          ? ayahsSuggestionResult()
                          : pagesSuggestionresult(),
                  Divider(),
                  SizedBox(height: MySiezes.screenPadding),
                ],
              )
            : Container(),
      ),
    ];

    return Column(children: [orderedResult[0], orderedResult[1], orderedResult[2]]);
  }

  Widget surahsSuggestionResult() {
    if (query == '') return Container();
    List<Surah> surahsResult = QuranHelper().getMatchedSurahs(query);
    return SizedBox(
      height: Get.size.height * .2,
      child: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 5 / 1.5),
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: surahsResult.length,
          itemBuilder: ((context, index) {
            return ListTile(
              onTap: () {
                Get.back();
                quranCtr.tabCtr.index = surahsResult[index].numberOfPage - 1;
              },
              title:
                  MyTexts.quranSecondTitle(title: '${surahsResult[index].name} : ${surahsResult[index].numberOfPage}'),
            );
          }),
        ),
      ),
    );
  }

  Widget ayahsSuggestionResult() {
    if (query == '') return Container();
    List<SearchedAyah> ayahsResult = QuranHelper().getMatchedAyahs(query);
    return SizedBox(
      height: Get.size.height * .6,
      child: Scrollbar(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ayahsResult.length,
                itemBuilder: (context, index) => suggestedAyahItem(searchedAyah: ayahsResult[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget suggestedAyahItem({required SearchedAyah searchedAyah}) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * .02, left: Get.height * .02, right: Get.height * .02),
      // padding: EdgeInsets.symmetric(horizontal: Get.height * .02),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ]),
      child: MaterialButton(
        onPressed: () {
          Get.back();
          quranCtr.tabCtr.index = searchedAyah.page - 1;
        },
        color: MyColors.quranItemBackGround(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MyTexts.quran(
                        title: '${searchedAyah.surahName}:', textAlign: TextAlign.right, color: MyColors.whiteBlack()),
                    SizedBox(width: Get.width * .03),
                    MyTexts.quran(
                        title: searchedAyah.ayahNumber.toString(),
                        textAlign: TextAlign.right,
                        color: MyColors.whiteBlack()),
                  ],
                ),
                MyTexts.quran(
                    title: searchedAyah.page.toString(), textAlign: TextAlign.right, color: MyColors.whiteBlack()),
              ],
            ),
            MyTexts.quran(title: searchedAyah.ayahText, textAlign: TextAlign.right, color: MyColors.quranSecond()),
          ],
        ),
      ),
    );
  }

  Widget pagesSuggestionresult() {
    if (query == '') return Container();
    List<int> pagesResult = QuranHelper().getMatchedPages(query);
    return SizedBox(
      height: Get.size.height * .2,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 5 / 1.5),
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: pagesResult.length,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: () {
              Get.back();
              quranCtr.tabCtr.index = pagesResult[index] - 1;
            },
            title: MyTexts.quranSecondTitle(title: pagesResult[index].toString()),
          );
        }),
      ),
    );
  }
}
