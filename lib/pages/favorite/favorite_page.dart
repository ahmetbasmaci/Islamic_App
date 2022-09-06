import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/components/zikr_cards.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/database/sqldb.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../../components/my_drawer.dart';
import '../../constents/constents.dart';
import 'favorite_page_ctr.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  static const id = 'FavoritePage';
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // List<ZikrData> zikrDataList = [];

  GetStorage getStorage = GetStorage();
  FavoriteCtr favoriteCtr = Get.find<FavoriteCtr>();
  @override
  void initState() {
    super.initState();
    favoriteCtr.selectedZikrType.value = ZikrType.values[getStorage.read('selectedZikrType') ?? 0];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'المفضلة',
          actions: [
            MyIcons.menu(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MySiezes.cardPadding),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ZikrType>(
                    iconEnabledColor: MyColors.primary(),
                    value: favoriteCtr.selectedZikrType.value,
                    items: [
                      DropdownMenuItem(value: ZikrType.all, child: MyTexts.dropDownMenuItem(title: 'الكل')),
                      DropdownMenuItem(
                          value: ZikrType.allahNames, child: MyTexts.dropDownMenuItem(title: 'أسماء الله')),
                      DropdownMenuItem(value: ZikrType.azkar, child: MyTexts.dropDownMenuItem(title: 'الاذكار')),
                      DropdownMenuItem(value: ZikrType.quran, child: MyTexts.dropDownMenuItem(title: 'القران')),
                      DropdownMenuItem(value: ZikrType.hadith, child: MyTexts.dropDownMenuItem(title: 'الحديث')),
                    ],
                    onChanged: (newSelectedType) {
                      getStorage.write('selectedZikrType', newSelectedType!.index);
                      setState(() {
                        favoriteCtr.selectedZikrType.value = newSelectedType;
                      });
                    }),
              ),
            ),
            IconButton(
              icon: MyIcons.search(),
              onPressed: () => showSearch(context: context, delegate: SearchDel()),
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: FavoriteBody());
  }
}

class FavoriteBody extends StatelessWidget {
  FavoriteBody({this.searchText = ''});
  String searchText;

  // late Future<List<ZikrData>> readDataFuture = readDataFromDb();
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final FavoriteCtr favoriteCtr = Get.find<FavoriteCtr>();
  List<ZikrData> allZikrDataList = [];
  List<ZikrData> mustShowZikrDataList = [];
  List<ZikrData> selectedZikrDataList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
      child: FutureBuilder(
        future: readDataFromDb(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            mustShowZikrDataList = snapshot.data as List<ZikrData>;
            // if (searchText != '') {
            //   for (var item in allZikrDataList) {
            //     if (item.content.contains(searchText)) {
            //       mustShowZikrDataList.add(item);
            //       mustShowZikrDataList.removeWhere((element) => !element.content.contains(searchText));
            //     }
            //   }
            // } else
            //   mustShowZikrDataList.addAll(allZikrDataList);
            if (searchText != '') {
              mustShowZikrDataList.removeWhere((element) => !element.content.contains(searchText));
            }
            if (favoriteCtr.selectedZikrType.value == ZikrType.all)
              selectedZikrDataList.addAll(mustShowZikrDataList);
            else
              for (var element in mustShowZikrDataList)
                if (element.zikrType == favoriteCtr.selectedZikrType.value) selectedZikrDataList.add(element);

            return AnimatedList(
              key: listKey,
              initialItemCount: selectedZikrDataList.length,
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  key: UniqueKey(),
                  sizeFactor: animation,
                  child: ZikrCard(
                    haveMargin: true,
                    onDeleteFromFavorite: () {
                      ZikrData deletingZikrData = selectedZikrDataList[index];
                      listKey.currentState!.removeItem(
                        index,
                        duration: Duration(milliseconds: 500),
                        (context, animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: ZikrCard(
                              haveMargin: true,
                            ).allahNamesCard(deletingZikrData),
                          );
                        },
                      );
                      mustShowZikrDataList.remove(selectedZikrDataList[index]);
                      selectedZikrDataList.removeAt(index);
                    },
                  ).byType(selectedZikrDataList[index]),
                );
              },
            );
          } else
            return MyCircularProgressIndecator();
        },
      ),
    );
  }

  Future<List<ZikrData>> readDataFromDb() async {
    SqlDb sqlDb = SqlDb();
    List<Map> listMap = await sqlDb.readData(SqlDb.dbName);
    List<ZikrData> tmpList = [];
    for (var i = 0; i < listMap.length; i++) {
      tmpList.add(
        ZikrData(
          zikrType: ZikrType.values[listMap[i]['zikrType']],
          title: listMap[i]['title'],
          content: listMap[i]['content'],
          description: listMap[i]['description'],
          ayahNumber: listMap[i]['numberInQuran'],
          surahNumber: listMap[i]['surahNumber'],
          isFavorite: true,
        ),
      );
    }
    // setState(() {});
    return tmpList;
  }
}

class SearchDel extends SearchDelegate {
  @override
  String get searchFieldLabel => 'بحث';

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith();

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.arrow_forward), onPressed: () => close(context, null))];

  @override //back button
  Widget? buildLeading(BuildContext context) => IconButton(icon: Icon(Icons.close), onPressed: () => query = '');

  @override
  Widget buildResults(BuildContext context) => FavoriteBody(searchText: query);

  @override
  Widget buildSuggestions(BuildContext context) => FavoriteBody(searchText: query);
}
