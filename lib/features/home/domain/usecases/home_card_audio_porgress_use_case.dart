import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import '../../../../core/packages/audio_manager/audio_manager.dart';
import '../../../../core/utils/params/params.dart';
import '../../home.dart';

class HomeCardAudioPorgressUseCase extends IUseCaseAsync<AudioStreamModel, NoParams> {
  IHomeRepository homeRepository;

  HomeCardAudioPorgressUseCase({required this.homeRepository});
  @override
  Future<Either<Failure, AudioStreamModel>> call(NoParams params) async {
    return homeRepository.getAudioProgress();
  }
}
