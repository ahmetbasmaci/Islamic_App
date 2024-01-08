import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerWriteDataIntoFileAsBytesSyncUseCase extends IUseCase<Unit, WriteDataIntoFileAsBytesSyncParams> {
  ITafseerManagerRepository tafseerRepository;

  TafseerWriteDataIntoFileAsBytesSyncUseCase({required this.tafseerRepository});

  @override
  Either<Failure, Unit> call(WriteDataIntoFileAsBytesSyncParams params) {
    return tafseerRepository.writeDataIntoFileIntoFileAsBytesSync(params.tafseerId, params.data);
  }
}
