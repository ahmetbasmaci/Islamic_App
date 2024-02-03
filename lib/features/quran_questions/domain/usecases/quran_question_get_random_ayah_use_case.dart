import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../../quran/quran.dart';
import '../../quran_questions.dart';

class QuranQuestionGetRandomAyahUseCase extends IUseCase<Ayah, GetRandomStartAyahParams> {
  final IQuranQuestionRepository repository;

  QuranQuestionGetRandomAyahUseCase({required this.repository});

  @override
  Either<Failure, Ayah> call(GetRandomStartAyahParams params) {
    return repository.getRandomPageStartAyah(
      params.juzFrom,
      params.juzTo,
      params.pageFrom,
      params.pageTo,
    );
  }
}



















