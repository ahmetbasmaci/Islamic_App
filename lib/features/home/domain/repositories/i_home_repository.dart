import 'package:dartz/dartz.dart';
import '../../data/models/hadith_card_model.dart';

import '../../../../core/error/failure/failure.dart';

abstract class IHomeRepository {
 Future<Either<Failure, Unit>> playPauseSingleAudio();
 Future<Either<Failure, HadithCardModel>> getRandomHadith();
}
