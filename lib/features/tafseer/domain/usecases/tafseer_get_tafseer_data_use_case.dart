import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/core/utils/params/params.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

class TafseerGetTafseerDataUseCase extends IUseCaseAsync<TafseersDataModel, TafseerIdParams> {
  final ITafseerRepository tafseerRepository;

  TafseerGetTafseerDataUseCase({required this.tafseerRepository});
  @override
  Future<Either<Failure, TafseersDataModel>> call(params) {
    return tafseerRepository.getTafseersData(params.tafseerId);
  }
}
