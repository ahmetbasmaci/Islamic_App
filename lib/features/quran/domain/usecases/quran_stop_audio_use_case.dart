import 'package:dartz/dartz.dart';
import 'package:zad_almumin/features/quran/domain/repositories/i_quran_data_repository.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
class QuranStopAudioUseCase extends IUseCaseAsync<bool, NoParams> {
  final IQuranDataRepository repository;

  QuranStopAudioUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.stopAudio();
  }
}
