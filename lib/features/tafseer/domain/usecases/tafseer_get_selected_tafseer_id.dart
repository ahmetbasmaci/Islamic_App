import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/i_use_case_async.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerGetSelectedTafseerId extends IUseCaseAsync<SelectedTafseerIdModel, NoParams> {
  ITafseerManagerRepository tafseerRepository;

  TafseerGetSelectedTafseerId({required this.tafseerRepository});
  @override
  Future<Either<Failure, SelectedTafseerIdModel>> call(NoParams params) {
    return tafseerRepository.getSelectedTafseerId;
  }
}
