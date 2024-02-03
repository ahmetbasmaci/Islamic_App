
import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../quran_questions.dart';

class QuranQuestionSaveQuestionTypeUseCase extends IUseCaseAsync<Unit, QuestionTypeParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionSaveQuestionTypeUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(QuestionTypeParams params) async {
    return repository.saveQuestionType(params.questionType);
  }
}
