import '../../../../core/packages/audio_player/audio_player.dart';

import '../../../../core/error/exceptions/app_exceptions.dart';

abstract class IHomeCardPlayPauseSingleAudioDataSource {
  Future<void> playPauseSingleAudio();
}

class HomeCardPlayPauseSingleAudioDataSource implements IHomeCardPlayPauseSingleAudioDataSource {
  AudioPlayer audioService;

  HomeCardPlayPauseSingleAudioDataSource({required this.audioService});
  @override
  Future<void> playPauseSingleAudio() async {
    try {
      await audioService.playPauseSingleAudio(
        audioPath: 'audioPath',
        metasTitle: 'metasTitle',
        metasArtist: 'etasArtist',
      );
    } on AudioException catch (e) {
      throw AudioException(e.message);
    } catch (e) {
      throw AudioException(e.toString());
    }
  }
}
