import 'package:http/http.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import '../../../../core/utils/api/api.dart';
import '../../tafseer.dart';

abstract class ITafseerDownloaderDataSource {
  Future<StreamedResponse> downloadTafseerStream(int tafseerId);
}

class TafseerDownloaderDataSource implements ITafseerDownloaderDataSource {
  final IFirebaseStorageConsumer firebaseStorageConsumer;
  final ApiConsumer apiConsumer;
  TafseerDownloaderDataSource({
    required this.firebaseStorageConsumer,
    required this.apiConsumer,
  });

  List<TafseerManagerModel> allTafseerData = [];
  @override
  Future<StreamedResponse> downloadTafseerStream(int tafseerId) async {
    String downloadUrl = await firebaseStorageConsumer.getUrl(FireBaseStorageFileName.tafseers, tafseerId);

    StreamedResponse response = await apiConsumer.getStream(downloadUrl);
    return response;
  }
}
