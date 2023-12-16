import 'package:dartz/dartz.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/i_use_case_async.dart';
import '../../../../core/utils/params/params.dart';
import '../repositories/i_home_repository.dart';

class HomeCardPlayPauseSingleAudioUseCase extends IUseCaseAsync<Unit, NoParams> {
  final IHomeRepository repository;

  HomeCardPlayPauseSingleAudioUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.playPauseSingleAudio();
  }
}
