import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';

import '../../favorite.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState.init());
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  void changeFavoriteZikrCategory(FavoriteZikrCategory newFavoriteZikrCategory) {
    emit(state.copyWith(favoriteZikrCategory: newFavoriteZikrCategory));
  }

  void readDataFromDb() {}
  void _loadFavoriteZikrCategory() {
    //TODO: implement loadFavoriteZikrCategory
    // FavoriteZikrCategory.values[getStorage.read('s electedZikrType') ?? 0]
    emit(state.copyWith(favoriteZikrCategory: FavoriteZikrCategory.all));
  }

  List<FavoriteZikrDataModel> getFilteredZikrModels(String searchText) {
    List<FavoriteZikrDataModel> favoriteZikrModels =
        state.favoriteZikrModels.where((element) => element.category == state.favoriteZikrCategory).toList();
    if (searchText.isNotEmpty) {
      favoriteZikrModels.removeWhere((element) => !element.content.contains(searchText));
    }
    favoriteZikrModels.add(
      FavoriteZikrDataModel(
        title: 'اللهم صلي على سيدنا محمد',
        content: 'اللهم صلي على سيدنا محمد',
        description: 'اللهم صلي على سيدنا محمد',
        category: FavoriteZikrCategory.all,
      ),
    );
    return favoriteZikrModels;
  }
}
