import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/widget/animations/animated_list_item_down_to_up.dart';
import '../../favorite.dart';

class FavoriteBody extends StatelessWidget {
  FavoriteBody({this.searchText = ''});
  String searchText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FavoriteSelectZikrType(),
        _savedDataCards(context),
      ],
    );
  }

  Widget _savedDataCards(BuildContext context) {
    List<FavoriteZikrDataModel> filteredModels = context.read<FavoriteCubit>().getFilteredZikrModels(searchText);
    return ListView.builder(
      key: context.read<FavoriteCubit>().listKey,
      itemCount: filteredModels.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        FavoriteZikrDataModel zikrDataModel = filteredModels[index];
        return AnimatedListItemDownToUp(
          index: index,
          child: FavoriteZikrCard(
            title: zikrDataModel.title,
            content: zikrDataModel.content,
            description: zikrDataModel.description,
          ),
        );
      },
    );
  }

  // Future<List<FavoriteZikrDataModel>> readDataFromDb() async {
  //   SqlDb sqlDb = SqlDb();
  //   List<Map> listMap = await sqlDb.readData(SqlDb.dbName);
  //   List<FavoriteZikrDataModel> tmpList = [];
  //   for (var i = 0; i < listMap.length; i++) {
  //     tmpList.add(
  //       FavoriteZikrDataModel(
  //         zikrType: FavoriteZikrCategorys[listMap[i]['zikrType']],
  //         title: listMap[i]['title'],
  //         content: listMap[i]['content'],
  //         description: listMap[i]['description'],
  //         ayahNumber: listMap[i]['numberInQuran'],
  //         surahNumber: listMap[i]['surahNumber'],
  //         isFavorite: true,
  //       ),
  //     );
  //   }
  //   // setState(() {});
  //   return tmpList;
  // }
}
