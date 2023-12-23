import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/failure/failure.dart';
import '../datasources/home_card_get_random_hadith_data_source/home_card_get_random_hadith_data_source.dart';
import '../models/hadith_card_model.dart';
import '../../../../core/error/exceptions/app_exceptions.dart';
import '../../domain/repositories/i_home_repository.dart';
import '../datasources/home_card_play_single_audio_data_source.dart';

class HomeRepository implements IHomeRepository {
  final IHomeCardPlayPauseSingleAudioDataSource homeCardPlayPauseSingleAudioDataSource;
  final IHomeCardGetRandomHadithDataSource homeCardGetRandomHadithDataSource;

  HomeRepository({
    required this.homeCardGetRandomHadithDataSource,
    required this.homeCardPlayPauseSingleAudioDataSource,
  });

  @override
  Future<Either<Failure, Unit>> playPauseSingleAudio() async {
    try {
      await homeCardPlayPauseSingleAudioDataSource.playPauseSingleAudio();
      return const Right(unit);
    } on AudioException catch (e) {
      debugPrint(e.toString());
      return Left(AudioFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HadithCardModel>> getRandomHadith() async {
    try {
      var result = await homeCardGetRandomHadithDataSource.getRandomHadith();
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }
}
