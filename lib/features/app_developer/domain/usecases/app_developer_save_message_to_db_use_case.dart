import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/utils/params/params.dart';

import '../../../../core/usecase/usecase.dart';
import '../../app_developer.dart';

class AppDeveloperSaveMessageToDbUseCase extends IUseCaseAsync<Unit, AddNewUserMessageParams> {
  final IAppDeveloperRepository appDeveloperRepository;

  AppDeveloperSaveMessageToDbUseCase({required this.appDeveloperRepository});
  @override
  Future<Either<Failure, Unit>> call(AddNewUserMessageParams params) async {
    return await appDeveloperRepository.saveMessageToDb(params.name, params.message);
  }
}
