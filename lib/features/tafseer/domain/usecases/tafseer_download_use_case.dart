import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerDownloadUseCase extends IUseCaseAsync<StreamedResponse, DownloadTafseerParams> {
  ITafseerManagerRepository tafseerRepository;

  TafseerDownloadUseCase({required this.tafseerRepository});

  @override
  Future<Either<Failure, StreamedResponse>> call(DownloadTafseerParams params) {
    return tafseerRepository.downloadTafseerStream(params.tafseerId);
  }
}
