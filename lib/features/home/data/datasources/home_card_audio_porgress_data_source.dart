import '../../../../core/packages/audio_manager/audio_manager.dart';

abstract class IHomeCardAudioPorgressDataSource {
  Future<AudioStreamModel> getAudioProgress();
}

class HomeCardAudioPorgressDataSource implements IHomeCardAudioPorgressDataSource {
  IAudioPlayer audioService;

  HomeCardAudioPorgressDataSource({
    required this.audioService,
  });

  @override
  Future<AudioStreamModel> getAudioProgress() {
    return audioService.streamPosition();
  }
}
