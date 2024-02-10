import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/favorite_button/domain/repositories/i_favorite_button_repository.dart';

import '../../../../core/utils/params/params.dart';

class FavoriteButtonCheckContentIfFavoriteUseCase extends IUseCaseAsync<bool, FavoriteParams> {
  final IFavoriteButtonRepository favoriteRepository;

  FavoriteButtonCheckContentIfFavoriteUseCase({required this.favoriteRepository});
  @override
  Future<Either<Failure, bool>> call(params) async {
    return await favoriteRepository.checkItemIfFavorite(params.content);
  }
}
