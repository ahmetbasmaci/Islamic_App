import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../../../constents/my_colors.dart';
import '../../../constents/my_texts.dart';
import '../../../moduls/enums.dart';
import '../models/surah.dart';
import '../controllers/quran_page_ctr.dart';
import 'draggable_filter_chip.dart';

class QuranSearchDelegate extends SearchDelegate {
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();

  @override
  String get searchFieldLabel => 'إبحث عن آية او سورة...'.tr;

  @override
  ThemeData appBarTheme(BuildContext context) => Get.find<ThemeCtr>().currentThemeMode.value.copyWith(
        scaffoldBackgroundColor: MyColors.quranBackGround(),
        iconTheme: IconThemeData(color: MyColors.quranPrimary()),
        textTheme: TextTheme(
          titleMedium: TextStyle(color: MyColors.quranPrimary()),
        ),
        appBarTheme: AppBarTheme(
          color: MyColors.quranBackGround(),
          iconTheme: IconThemeData(color: MyColors.quranPrimary()),
          titleTextStyle: TextStyle(color: MyColors.quranPrimary()),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          labelStyle: MyTexts.main(title: '', color: MyColors.quranPrimary()).style,
        ),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding / 2),
      child: SingleChildScrollView(
        physics: query.isEmpty ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MySiezes.screenPadding),
            DraggableFilterChip(),
            SizedBox(height: MySiezes.screenPadding),
            searchSuggestionResultOrder(),
          ],
        ),
      ),
    );
  }

  Widget searchSuggestionResultOrder() {
    List<Widget> orderedResult = [
      Obx(
        () => _quranCtr.searchFilterList[0].value.isSelected.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AppSettings.isArabicLang ? Alignment.topRight : Alignment.topLeft,
                    child: MyTexts.quranSecondTitle(
                        title: _quranCtr.searchFilterList[0].value.text.tr, size: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySiezes.screenPadding),
                  _quranCtr.searchFilterList[0].value.searchFilter == SearchFilter.surah
                      ? surahsSuggestionResult()
                      : _quranCtr.searchFilterList[0].value.searchFilter == SearchFilter.ayah
                          ? ayahsSuggestionResult()
                          : pagesSuggestionresult(),
                  Divider(),
                  SizedBox(height: MySiezes.screenPadding),
                ],
              )
            : Container(),
      ),
      Obx(
        () => _quranCtr.searchFilterList[1].value.isSelected.value
            ? Column(
                children: [
                  Align(
                    alignment: AppSettings.isArabicLang ? Alignment.topRight : Alignment.topLeft,
                    child: MyTexts.quranSecondTitle(
                        title: _quranCtr.searchFilterList[1].value.text.tr, size: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySiezes.screenPadding),
                  _quranCtr.searchFilterList[1].value.searchFilter == SearchFilter.surah
                      ? surahsSuggestionResult()
                      : _quranCtr.searchFilterList[1].value.searchFilter == SearchFilter.ayah
                          ? ayahsSuggestionResult()
                          : pagesSuggestionresult(),
                  Divider(),
                  SizedBox(height: MySiezes.screenPadding),
                ],
              )
            : Container(),
      ),
      Obx(
        () => _quranCtr.searchFilterList[2].value.isSelected.value
            ? Column(
                children: [
                  Align(
                    alignment: AppSettings.isArabicLang ? Alignment.topRight : Alignment.topLeft,
                    child: MyTexts.quranSecondTitle(
                        title: _quranCtr.searchFilterList[2].value.text.tr, size: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySiezes.screenPadding),
                  _quranCtr.searchFilterList[2].value.searchFilter == SearchFilter.surah
                      ? surahsSuggestionResult()
                      : _quranCtr.searchFilterList[2].value.searchFilter == SearchFilter.ayah
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
    List<Surah> surahsResult = _quranCtr.searchSurahs(query);
    return Container(
      constraints: BoxConstraints(maxHeight: Get.size.height * .2),
      child: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 5 / 1.5),
          shrinkWrap: true,
          physics: surahsResult.isEmpty
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: surahsResult.length,
          cacheExtent: 5,
          itemBuilder: ((context, index) {
            return ListTile(
              onTap: () {
                Get.back();
                _quranCtr.tabCtr.index = surahsResult[index].startAtPage - 1;
              },
              title: MyTexts.quranSecondTitle(
                  title:
                      '${surahsResult[index].name.replaceAll('سُورَةُ '.tr, '')} : ${surahsResult[index].startAtPage}'),
            );
          }),
        ),
      ),
    );
  }

  Widget ayahsSuggestionResult() {
    if (query == '') return Container();
    _quranCtr.searchAyahs(query);
    return Container(
      constraints: BoxConstraints(maxHeight: Get.size.height * .6),
      child: Scrollbar(
        child: StreamBuilder<List<Ayah>>(
          stream: _quranCtr.ayahsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Ayah> matchedAyahs = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: matchedAyahs.length,
                itemBuilder: (context, index) => suggestedAyahItem(ayah: matchedAyahs[index]),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget suggestedAyahItem({required Ayah ayah}) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * .02),
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
          _quranCtr.selectedAyah.value = ayah;
          _quranCtr.updateCurrentPageToCurrentAyah();
          // _quranCtr.tabCtr.index = ayah.page - 1;
        },
        color: MyColors.quranBackGround(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MyTexts.main(
                        title: '${AppSettings.removeTashkil(ayah.surahName).tr}:',
                        textAlign: TextAlign.right,
                        color: MyColors.quranPrimary()),
                    SizedBox(width: Get.width * .03),
                    MyTexts.main(
                        title: ayah.ayahNumber.toString(), textAlign: TextAlign.right, color: MyColors.quranPrimary()),
                  ],
                ),
                Row(
                  children: [
                    MyTexts.main(
                        title: "${'الصفحة'.tr}:  ".toString(),
                        textAlign: TextAlign.right,
                        color: MyColors.quranPrimary()),
                    MyTexts.main(
                      title: ayah.page.toString(),
                      textAlign: TextAlign.right,
                      color: MyColors.quranPrimary(),
                    ),
                  ],
                ),
              ],
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: MyTexts.quran(
                title: ayah.text,
                textAlign: TextAlign.justify,
                color: MyColors.whiteBlack(),
                fontSize: _quranCtr.quranFontSize.value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pagesSuggestionresult() {
    if (query == '') return Container();
    List<int> pagesResult = _quranCtr.searchPages(query);
    return Container(
      constraints: BoxConstraints(maxHeight: Get.size.height * .2),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 5 / 1.5),
        shrinkWrap: true,
        physics: pagesResult.isEmpty ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
        itemCount: pagesResult.length,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: () {
              Get.back();
              _quranCtr.tabCtr.index = pagesResult[index] - 1;
            },
            title: MyTexts.quranSecondTitle(title: pagesResult[index].toString()),
          );
        }),
      ),
    );
  }
}
