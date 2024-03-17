import 'package:http/http.dart';
import 'package:zad_almumin/core/packages/app_internet_connection/app_internet_connection.dart';
import 'package:zad_almumin/core/services/files_service.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';

import '../../../../core/packages/audio_manager/audio_manager.dart';

import '../../../../core/error/exceptions/app_exceptions.dart';
import '../../../../core/utils/api/ayah/ayah_api.dart';
import '../../../../core/utils/api/consumer/consumer.dart';
import '../../home.dart';

abstract class IHomeCardPlayPauseSingleAudioDataSource {
  Future<bool> playPauseSingleAudio(QuranCardModel quranCardModel, QuranReader quranReader, Function onComplated);
}

class HomeCardPlayPauseSingleAudioDataSource implements IHomeCardPlayPauseSingleAudioDataSource {
  IAudioPlayer audioService;
  ApiConsumer apiConsumer;
  IFilesService fileService;
  IAyahApi ayahApi;
  IAppInternetConnection appInternetConnection;

  HomeCardPlayPauseSingleAudioDataSource({
    required this.audioService,
    required this.apiConsumer,
    required this.fileService,
    required this.ayahApi,
    required this.appInternetConnection,
  });
  @override
  Future<bool> playPauseSingleAudio(QuranCardModel quranCardModel, QuranReader quranReader, Function onComplate) async {
    try {
      //check if file exist
      bool fileExist = await fileService.checkIfAyahFileDownloaded(
          quranCardModel.surahNumber, quranCardModel.ayahNumber, quranReader);
      if (!fileExist) {
        //if not exist try to download it
        await _downloadAyah(quranCardModel.surahNumber, quranCardModel.ayahNumber, quranReader);
      }
      AudioFile audioFile = AudioFile(
        path: fileService.ayahPath(quranCardModel.surahNumber, quranCardModel.ayahNumber, quranReader),
        metasTitle: quranCardModel.surahName,
        metasArtist: '${quranCardModel.surahNumber}:${quranCardModel.ayahNumber}',
        metasAlbum: quranCardModel.ayahNumber.toString(),
      );
      bool audioComplated = await audioService.playPauseSingleAudio(audioFile, onComplate);
      return audioComplated;
    } catch (e) {
      throw AudioException(e.toString());
    }
  }

  Future<void> _downloadAyah(int surahNumber, int ayahNumber, QuranReader quranReader) async {
    //check internet connection
    AppConnectivityResult connectivityResult = await appInternetConnection.checkAppConnectivity();
    if (connectivityResult == AppConnectivityResult.none) {
      throw ServerException('No Internet Connection');
    }

    String url = ayahApi.getAyahDownloadUrl(surahNumber, ayahNumber, quranReader);

    Response response = await apiConsumer.get(url);
    if (response.statusCode == 200) {
      String filePath = fileService.ayahPath(surahNumber, ayahNumber, quranReader);
      await fileService.writeDataIntoFileAsBytes(filePath, response.bodyBytes);
    }
  }
}
