import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/quran/quran.dart';

import '../../../../core/utils/params/params.dart';

class HomeCardGetRandomAyahUseCase extends IUseCaseAsync<Ayah, NoParams> {
  IQuranDataRepository quranDataRepository;

  HomeCardGetRandomAyahUseCase({required this.quranDataRepository});
  @override
  Future<Either<Failure, Ayah>> call(NoParams params) async {
    return quranDataRepository.getRandomAyah();
  }
}
