import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../quran_questions.dart';

class QuranQuestionGetJuzFromUseCase extends IUseCase<int?, NoParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionGetJuzFromUseCase({required this.repository});

  @override
  Either<Failure, int?> call(NoParams params) {
    return repository.getJuzFrom;
  }
}