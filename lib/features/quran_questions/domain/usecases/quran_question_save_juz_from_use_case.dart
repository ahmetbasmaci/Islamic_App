import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../quran_questions.dart';

class QuranQuestionSaveJuzFromUseCase extends IUseCaseAsync<Unit, JuzFromParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionSaveJuzFromUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(JuzFromParams params) async {
    return repository.saveJuzFrom(params.juzFrom);
  }
}