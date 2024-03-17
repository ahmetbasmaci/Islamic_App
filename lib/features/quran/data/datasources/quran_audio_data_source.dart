import 'package:http/http.dart';

import '../../../../core/error/exceptions/app_exceptions.dart';
import '../../../../core/packages/app_internet_connection/app_internet_connection.dart';
import '../../../../core/packages/audio_manager/audio_manager.dart';
import '../../../../core/services/files_service.dart';
import '../../../../core/utils/api/ayah/ayah_api.dart';
import '../../../../core/utils/api/consumer/consumer.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../quran.dart';

abstract class IQuranAudioDataSource {
  Future<bool> playPauseMultibleAudio(
    List<Ayah> ayahs,
    int startAyahIndex,
    QuranReader quranReader,
    Function(Ayah complatedAyah, bool partEnded) onComplated,
  );

  Future<bool> stopAudio();
  Future<AudioStreamModel> getAudioProgress();
  bool get isAudioPlaying;
}

class QuranAudioDataSource implements IQuranAudioDataSource {
  IAudioPlayer audioService;
  ApiConsumer apiConsumer;
  IFilesService fileService;
  IAyahApi ayahApi;
  IAppInternetConnection appInternetConnection;

  QuranAudioDataSource({
    required this.audioService,
    required this.apiConsumer,
    required this.fileService,
    required this.ayahApi,
    required this.appInternetConnection,
  });

  @override
  Future<AudioStreamModel> getAudioProgress() {
    // TODO: implement getAudioProgress
    throw UnimplementedError();
  }

  @override
  Future<bool> playPauseMultibleAudio(
    List<Ayah> ayahs,
    int startAyahIndex,
    QuranReader quranReader,
    Function(Ayah complatedAyah, bool partEnded) onComplate,
  ) async {
    try {
      //check if file exist
      //bool fileExist = false;
      bool fileExist = await fileService.checkIfSurahFileDownloaded(ayahs[0].surahNumber, quranReader);
      if (!fileExist) {
        //if not exist try to download it
        await _downloadSurah(ayahs[0].surahNumber, quranReader);
      }

      List<AudioFile> audioFiles = [];

      for (Ayah ayah in ayahs) {
        audioFiles.add(
          AudioFile(
            path: fileService.ayahFromSurahPath(ayah.surahNumber, ayah.number, quranReader),
            metasTitle: ayah.surahName,
            metasArtist: quranReader.name,
            metasAlbum: ayah.number.toString(),
            extra: ayah.toJson(),
          ),
        );
      }
      bool audioComplated = await audioService.playPauseMultibleAudio(audioFiles, startAyahIndex, onComplate);
      return audioComplated;
    } catch (e) {
      throw AudioException(e.toString());
    }
  }

  Future<void> _downloadSurah(int surahNumber, QuranReader quranReader) async {
    //check internet connection
    AppConnectivityResult connectivityResult = await appInternetConnection.checkAppConnectivity();
    if (connectivityResult == AppConnectivityResult.none) {
      throw ServerException('No Internet Connection');
    }

    String url = ayahApi.getSurahZipDownloadUrl(surahNumber, quranReader);

    Response response = await apiConsumer.get(url);
    if (response.statusCode == 200) {
      String filePath = fileService.surahPath(surahNumber, quranReader);
      await fileService.writeDataIntoFileAsBytes(filePath, response.bodyBytes);
      await fileService.unArchiveAndSave(filePath);
    }
  }

  @override
  Future<bool> stopAudio() async {
    await audioService.stopAudio();
    return true;
  }

  @override
  bool get isAudioPlaying {
    return audioService.isPlaying;
  }
}
