import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../quran_questions.dart';

class QuranQuestionSaveAnswerTypeUseCase extends IUseCaseAsync<Unit, AnswerTypeParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionSaveAnswerTypeUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(AnswerTypeParams params) async {
    return repository.saveAnswerType(params.answerType);
  }
}
