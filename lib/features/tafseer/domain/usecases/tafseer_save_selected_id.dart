import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerSaveSelectedIdUseCase extends IUseCaseAsync<Unit, TafseerIdModelParams> {
  ITafseerRepository tafseerRepository;

  TafseerSaveSelectedIdUseCase({required this.tafseerRepository});

  @override
  Future<Either<Failure, Unit>> call(TafseerIdModelParams params) async {
    return await tafseerRepository.saveSelectedTafseer(params.tafseerIdModel);
  }
}
