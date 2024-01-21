import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerCheckIfDownloadedUseCase extends IUseCaseAsync<bool, TafseerIdParams> {
  ITafseerRepository tafseerRepository;

  TafseerCheckIfDownloadedUseCase({required this.tafseerRepository});

  @override
  Future<Either<Failure, bool>> call(TafseerIdParams params) {
    return tafseerRepository.checkTafseerIfDownloaded(params.tafseerId);
  }
}
