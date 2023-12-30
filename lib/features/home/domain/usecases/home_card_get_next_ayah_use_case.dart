import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/quran/quran.dart';

import '../../../../core/utils/params/params.dart';

class HomeCardGetNextAyahUseCase extends IUseCaseAsync<Ayah, GetNextAyahParams> {
  IQuranDataRepository quranDataRepository;

  HomeCardGetNextAyahUseCase({required this.quranDataRepository});
  @override
  Future<Either<Failure, Ayah>> call(GetNextAyahParams params) async {
    return quranDataRepository.getAyah(params.surahNumber, params.ayahNumber);
  }
}
