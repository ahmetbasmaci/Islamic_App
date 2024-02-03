import '../../../../core/packages/local_storage/local_storage.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/resources/resources.dart';

abstract class IQuranQuestionSaveToDbDataSource {
  Future<void> savePageFrom(int pageFrom);
  Future<void> savePageTo(int pageTo);
  Future<void> saveJuzFrom(int juzFrom);
  Future<void> saveJuzTo(int juzTo);
  Future<void> saveQuestionType(QuestionType questionType);
  Future<void> saveAnswerType(AyahsAnswersType answerType);
}

class QuranQuestionSaveToDbDataSource implements IQuranQuestionSaveToDbDataSource {
  final ILocalStorage localStorage;

  QuranQuestionSaveToDbDataSource({required this.localStorage});
  @override
  Future<void> savePageFrom(int pageFrom) async {
    await localStorage.write(AppStorageKeys.pageFrom, pageFrom);
  }

  @override
  Future<void> savePageTo(int pageTo) async {
    await localStorage.write(AppStorageKeys.pageTo, pageTo);
  }

  @override
  Future<void> saveJuzFrom(int juzFrom) async {
    await localStorage.write(AppStorageKeys.juzFrom, juzFrom);
  }

  @override
  Future<void> saveJuzTo(int juzTo) async {
    await localStorage.write(AppStorageKeys.juzTo, juzTo);
  }

  @override
  Future<void> saveQuestionType(QuestionType questionType) async {
    await localStorage.write(AppStorageKeys.questionType, questionType.name);
  }

  @override
  Future<void> saveAnswerType(AyahsAnswersType answerType) async {
    await localStorage.write(AppStorageKeys.answerType, answerType.name);
  }
}
