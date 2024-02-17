import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions/app_exceptions.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/packages/audio_manager/audio_manager.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../home.dart';

class HomeRepository implements IHomeRepository {
  final IHomeCardPlayPauseSingleAudioDataSource homeCardPlayPauseSingleAudioDataSource;
  final IHomeCardGetRandomHadithDataSource homeCardGetRandomHadithDataSource;
  final IHomeCardAudioPorgressDataSource homeCardAudioPorgressDataSource;
  HomeRepository({
    required this.homeCardGetRandomHadithDataSource,
    required this.homeCardPlayPauseSingleAudioDataSource,
    required this.homeCardAudioPorgressDataSource,
  });

  @override
  Future<Either<Failure, bool>> playPauseSingleAudio(
    QuranCardModel quranCardModel,
    QuranReader quranReader,
    Function onComplated,
  ) async {
    try {
      bool audioComplated =
          await homeCardPlayPauseSingleAudioDataSource.playPauseSingleAudio(quranCardModel, quranReader, onComplated);
      return Right(audioComplated);
    } on AudioException catch (e) {
      return Left(AudioFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HadithCardModel>> getRandomHadith() async {
    try {
      var result = await homeCardGetRandomHadithDataSource.getRandomHadith();
      return Right(result);
    } catch (e) {
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AudioStreamModel>> getAudioProgress() async {
    try {
      var result = await homeCardAudioPorgressDataSource.getAudioProgress();
      return Right(result);
    } catch (e) {
      return Left(AudioFailure(e.toString()));
    }
  }
}
