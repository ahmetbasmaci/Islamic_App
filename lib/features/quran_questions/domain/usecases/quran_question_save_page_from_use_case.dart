import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../quran_questions.dart';

class QuranQuestionSavePageFromUseCase extends IUseCaseAsync<Unit, PageFromParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionSavePageFromUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(PageFromParams params) async {
    return repository.savePageFrom(params.pageFrom);
  }
}