import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/params/params.dart';
import '../../favorite_button.dart';

part 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  final FavoriteButtonRemoveItemUseCase favoriteButtonRemoveItemUseCase;
  final FavoriteButtonCheckContentIfFavoriteUseCase favoriteButtonCheckContentIfFavoriteUseCase;
  final FavoriteButtonAddItemUseCase favoriteButtonAddItemUseCase;
  bool isFavorite = false;
  FavoriteButtonCubit({
    required this.favoriteButtonRemoveItemUseCase,
    required this.favoriteButtonCheckContentIfFavoriteUseCase,
    required this.favoriteButtonAddItemUseCase,
  }) : super(const FavoriteButtonInitialState());

  Future<void> checkIfItemIsFavorite(String content) async {
    var result = await favoriteButtonCheckContentIfFavoriteUseCase(FavoriteParams(content: content));

    result.fold(
      (l) => emit(const FavoriteButtonErrorState()),
      (isFavoriteResponse) => emit(FavoriteButtonInitialState(isFavorite: isFavoriteResponse)),
    );
  }

  Future<void> changeFavoriteStatus(String content) async {
    if (isFavorite) {
      _removeItem(content);
    } else {
      _addItem(content);
    }
  }

  Future<void> _removeItem(String content) async {
    var result = await favoriteButtonRemoveItemUseCase(FavoriteParams(content: content));

    result.fold(
      (l) => emit(const FavoriteButtonErrorState()),
      (r) => emit(const FavoriteButtonInitialState(isFavorite: false)),
    );
  }

  Future<void> _addItem(String content) async {
    var result = await favoriteButtonAddItemUseCase(FavoriteParams(content: content));

    result.fold(
      (l) => emit(const FavoriteButtonErrorState()),
      (r) => emit(const FavoriteButtonInitialState(isFavorite: true)),
    );
  }
}
