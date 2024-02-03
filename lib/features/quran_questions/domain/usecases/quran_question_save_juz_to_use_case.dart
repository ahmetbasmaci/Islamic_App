
import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../quran_questions.dart';

class QuranQuestionSaveJuzToUseCase extends IUseCaseAsync<Unit, JuzToParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionSaveJuzToUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(JuzToParams params) async {
    return repository.saveJuzTo(params.juzTo);
  }
}