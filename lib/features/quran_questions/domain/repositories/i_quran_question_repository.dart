import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../quran/quran.dart';

abstract class IQuranQuestionRepository {
  Either<Failure, Ayah> getRandomPageStartAyah(int juzFrom, int juzTo, int pageFrom, int pageTo);

  Future<Either<Failure, Unit>> savePageFrom(int pageFrom);
  Future<Either<Failure, Unit>> savePageTo(int pageTo);
  Future<Either<Failure, Unit>> saveJuzFrom(int juzFrom);
  Future<Either<Failure, Unit>> saveJuzTo(int juzTo);
  Future<Either<Failure, Unit>> saveQuestionType(QuestionType questionType);
  Future<Either<Failure, Unit>> saveAnswerType(AyahsAnswersType answerType);

  Either<Failure, int?> get getPageFrom;
  Either<Failure, int?> get getPageTo;
  Either<Failure, int?> get getJuzFrom;
  Either<Failure, int?> get getJuzTo;
  Either<Failure, int?> get getQuestionType;
  Either<Failure, int?> get getAnswerType;
}
