import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/components/zikr_card/zikr_cards.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/database/sqldb.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/classes/quran_helper.dart';
import 'favorite_page_ctr.dart';

class FavoriteBody extends StatelessWidget {
  FavoriteBody({this.searchText = ''});
  String searchText;

  // late Future<List<ZikrData>> readDataFuture = readDataFromDb();
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final FavoriteCtr favoriteCtr = Get.find<FavoriteCtr>();
  List<ZikrData> allZikrDataList = [];
  List<ZikrData> allFavoriteDataList = [];
  List<ZikrData> selectedZikrDataList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
      child: FutureBuilder(
        future: allFavoriteDataList.isEmpty ? readDataFromDb() : Future.delayed(Duration(seconds: 0)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            allFavoriteDataList = snapshot.data as List<ZikrData>;
            if (searchText != '') {
              allFavoriteDataList
                  .removeWhere((element) => !QuranHelper().normalise(element.content).contains(searchText));
            }
            if (favoriteCtr.selectedZikrType.value == ZikrType.all)
              selectedZikrDataList.addAll(allFavoriteDataList);
            else
              for (var element in allFavoriteDataList)
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
                      //allFavoriteDataList.remove(selectedZikrDataList[index]);
                      //selectedZikrDataList.removeAt(index);
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
