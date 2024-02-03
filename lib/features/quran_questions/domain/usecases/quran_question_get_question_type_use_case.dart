
import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../quran_questions.dart';

class QuranQuestionGetQuestionTypeUseCase extends IUseCase<int?, NoParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionGetQuestionTypeUseCase({required this.repository});

  @override
  Either<Failure, int?> call(NoParams params) {
    return repository.getQuestionType;
  }
}