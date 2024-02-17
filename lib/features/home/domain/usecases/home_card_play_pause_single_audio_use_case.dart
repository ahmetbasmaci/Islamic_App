import 'package:dartz/dartz.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/i_use_case_async.dart';
import '../../../../core/utils/params/params.dart';
import '../repositories/i_home_repository.dart';

class HomeCardPlayPauseSingleAudioUseCase extends IUseCaseAsync<bool, PlayAudioParams> {
  final IHomeRepository repository;

  HomeCardPlayPauseSingleAudioUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(PlayAudioParams params) {
    return repository.playPauseSingleAudio(params.quranCardModel, params.quranReader,params.onComplated);
  }
}
