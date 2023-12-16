import 'package:dartz/dartz.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/i_use_case_async.dart';
import '../../../../core/usecase/params/params.dart';
import '../../data/models/hadith_card_model.dart';
import '../repositories/i_home_repository.dart';

class HomeCardGetRandomHadithUseCase extends IUseCaseAsync<HadithCardModel, NoParams> {
  final IHomeRepository repository;
  HomeCardGetRandomHadithUseCase({required this.repository});
  @override
  Future<Either<Failure, HadithCardModel>> call(params) async {
    return repository.getRandomHadith();
  }
}
