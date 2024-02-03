import '../../../../core/packages/local_storage/local_storage.dart';
import '../../../../core/utils/resources/resources.dart';

abstract class IQuranQuestionReadFromDbDataSource {
  int? get getPageFrom;
  int? get getPageTo;
  int? get getJuzFrom;
  int? get getJuzTo;
  int? get getQuestionType;
  int? get getAnswerType;
}

class QuranQuestionReadFromDbDataSource implements IQuranQuestionReadFromDbDataSource {
  final ILocalStorage localStorage;

  QuranQuestionReadFromDbDataSource({required this.localStorage});

  @override
  int? get getPageFrom => localStorage.read(AppStorageKeys.pageFrom);

  @override
  int? get getPageTo => localStorage.read(AppStorageKeys.pageTo);

  @override
  int? get getJuzFrom => localStorage.read(AppStorageKeys.juzFrom);

  @override
  int? get getJuzTo => localStorage.read(AppStorageKeys.juzTo);

  @override
  int? get getQuestionType => localStorage.read(AppStorageKeys.questionType);

  @override
  int? get getAnswerType => localStorage.read(AppStorageKeys.answerType);
}
