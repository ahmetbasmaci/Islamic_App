import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/favorite_button/domain/repositories/i_favorite_button_repository.dart';

import '../../../../core/utils/params/params.dart';

class FavoriteButtonAddItemUseCase extends IUseCaseAsync<Unit, FavoriteParams> {
  final IFavoriteButtonRepository favoriteRepository;

  FavoriteButtonAddItemUseCase({required this.favoriteRepository});
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await favoriteRepository.addItem(params.content);
  }
}
