import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../quran_questions.dart';

class QuranQuestionSavePageToUseCase extends IUseCaseAsync<Unit, PageToParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionSavePageToUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(PageToParams params) async {
    return repository.savePageTo(params.pageTo);
  }
}