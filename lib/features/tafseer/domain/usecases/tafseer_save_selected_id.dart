import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerSaveSelectedIdUseCase extends IUseCaseAsync<Unit, TafseerIdParams> {
  ITafseerManagerRepository tafseerRepository;

  TafseerSaveSelectedIdUseCase({required this.tafseerRepository});

  @override
  Future<Either<Failure, Unit>> call(TafseerIdParams params) async {
    return await tafseerRepository.saveSelectedTafseer(params.tafseerId);
  }
}
