import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../quran/quran.dart';
import '../../quran_questions.dart';

class QuranQuestionRepository implements IQuranQuestionRepository {
  final IQuranQuestionGetRandomPageStartAyahDataSource quranQuestionGetRandomPageStartAyahDataSource;
  final IQuranQuestionSaveToDbDataSource quranQuestionSaveToDbDataSource;
  final IQuranQuestionReadFromDbDataSource quranQuestionReadFromDbDataSource;
  QuranQuestionRepository({
    required this.quranQuestionGetRandomPageStartAyahDataSource,
    required this.quranQuestionSaveToDbDataSource,
    required this.quranQuestionReadFromDbDataSource,
  });

  @override
  Either<Failure, Ayah> getRandomPageStartAyah(
    int juzFrom,
    int juzTo,
    int pageFrom,
    int pageTo,
  ) {
    try {
      final result = quranQuestionGetRandomPageStartAyahDataSource.getRandomPageStartAyah(
        juzFrom,
        juzTo,
        pageFrom,
        pageTo,
      );
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> savePageFrom(int pageFrom) async {
    try {
      await quranQuestionSaveToDbDataSource.savePageFrom(pageFrom);
      return const Right(unit);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int?> get getAnswerType {
    try {
      final result = quranQuestionReadFromDbDataSource.getAnswerType;
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int?> get getJuzFrom {
    try {
      final result = quranQuestionReadFromDbDataSource.getJuzFrom;
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int?> get getJuzTo {
    try {
      final result = quranQuestionReadFromDbDataSource.getJuzTo;
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int?> get getPageFrom {
    try {
      final result = quranQuestionReadFromDbDataSource.getPageFrom;
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int?> get getPageTo {
    try {
      final result = quranQuestionReadFromDbDataSource.getPageTo;
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int?> get getQuestionType {
    try {
      final result = quranQuestionReadFromDbDataSource.getQuestionType;
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveJuzFrom(int juzFrom) async {
    try {
      quranQuestionSaveToDbDataSource.saveJuzFrom(juzFrom);
      return const Right(unit);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveJuzTo(int juzTo) async {
    try {
      await quranQuestionSaveToDbDataSource.saveJuzTo(juzTo);
      return const Right(unit);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> savePageTo(int pageTo) async {
    try {
      await quranQuestionSaveToDbDataSource.savePageTo(pageTo);
      return const Right(unit);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveAnswerType(AyahsAnswersType answerType) async {
    try {
      await quranQuestionSaveToDbDataSource.saveAnswerType(answerType);
      return const Right(unit);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveQuestionType(QuestionType questionType) async {
    try {
      await quranQuestionSaveToDbDataSource.saveQuestionType(questionType);
      return const Right(unit);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }
}
