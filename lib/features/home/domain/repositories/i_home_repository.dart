import 'package:dartz/dartz.dart';
import '../../../../core/packages/audio_manager/audio_manager.dart';
import '../../../../core/utils/enums/enums.dart';

import '../../../../core/error/failure/failure.dart';
import '../../home.dart';

abstract class IHomeRepository {
  Future<Either<Failure, bool>> playPauseSingleAudio(
    QuranCardModel quranCardModel,
    QuranReader quranReader,
    Function onComplated,
  );
  Future<Either<Failure, HadithCardModel>> getRandomHadith();
   Future<Either<Failure, AudioStreamModel>>  getAudioProgress();
}
