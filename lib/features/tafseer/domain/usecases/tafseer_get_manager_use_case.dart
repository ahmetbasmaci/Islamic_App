import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerGetManagerUseCase extends IUseCaseAsync<List<TafseerManagerModel>, NoParams> {
  ITafseerRepository tafseerRepository;

  TafseerGetManagerUseCase({required this.tafseerRepository});

  @override
  Future<Either<Failure, List<TafseerManagerModel>>> call(NoParams params) {
    return tafseerRepository.getTafsers;
  }
}
