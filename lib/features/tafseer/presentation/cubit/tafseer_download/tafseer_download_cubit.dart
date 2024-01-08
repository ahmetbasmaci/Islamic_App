import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/params/params.dart';
import '../../../tafseer.dart';

part 'tafseer_download_state.dart';

class TafseerDownloadCubit extends Cubit<TafseerDownloadState> {
  final TafseerDownloadUseCase downloadTafseerUseCase;
  final TafseerCheckIfDownloadedUseCase checkTafseerIfDownloadedUseCase;
  final TafseerWriteDataIntoFileAsBytesSyncUseCase tafseerWriteDataIntoFileAsBytesSyncUseCase;

  TafseerDownloadCubit({
    required this.downloadTafseerUseCase,
    required this.checkTafseerIfDownloadedUseCase,
    required this.tafseerWriteDataIntoFileAsBytesSyncUseCase,
  }) : super(TafseerDownloadInitialState());

  void downlaodTafseer(TafseerManagerModel tafseerModel) async {
    var result = await downloadTafseerUseCase.call(DownloadTafseerParams(tafseerId: tafseerModel.id));
    result.fold(
      (l) => emit(TafseerDownloadErrorState(message: l.message)),
      (response) async {
        tafseerModel.downloadState = DownloadState.downloading;

        var receivedBytes = 0;
        int contentLength = response.contentLength ?? 0;
        await response.stream.forEach(
          (data) {
            receivedBytes += data.length;
            final String progress = (receivedBytes / contentLength * 100).toStringAsFixed(1);
            var writeIntoFileResult = tafseerWriteDataIntoFileAsBytesSyncUseCase.call(
              WriteDataIntoFileAsBytesSyncParams(tafseerId: tafseerModel.id, data: data),
            );
            writeIntoFileResult.fold(
              (l) => emit(TafseerDownloadErrorState(message: l.message)),
              (r) => emit(TafseerDownloadDownloadingState(
                progress: double.parse(progress),
                tafseerManagerModel: tafseerModel,
              )),
            );
          },
        );

        var checkTafseerIfDownloadedResult = await checkTafseerIfDownloadedUseCase.call(
          TafseerIdParams(tafseerId: tafseerModel.id),
        );

        checkTafseerIfDownloadedResult.fold(
          (l) {
            tafseerModel.downloadState = DownloadState.notDownloaded;
            emit(TafseerDownloadErrorState(message: l.message));
          },
          (r) {
            tafseerModel.downloadState = DownloadState.downloaded;
            emit(TafseerDownloadedState());
//TODO
            //        if (tafseersCtr.selectedTafseerId == 0) {
            //   tafseersCtr.updateSelectedTafseerId(tafseerModel.id);
            //   await JsonService.loadTafseer();
            // }
          },
        );
      },
    );
  }
}
