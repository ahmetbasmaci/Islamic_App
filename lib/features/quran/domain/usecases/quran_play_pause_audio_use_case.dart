import 'package:dartz/dartz.dart';
import 'package:zad_almumin/features/quran/domain/repositories/i_quran_data_repository.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';

class QuranPlayPauseAudioUseCase extends IUseCaseAsync<bool, PlayMultibleAudioParams> {
  final IQuranDataRepository repository;

  QuranPlayPauseAudioUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(PlayMultibleAudioParams params) {
    return repository.playPauseSingleAudio(params.ayahs,params.startAyahIndex, params.quranReader, params.onComplated);
  }
}
