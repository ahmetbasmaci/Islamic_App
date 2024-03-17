import '../../../../core/packages/audio_manager/audio_manager.dart';

abstract class IQuranAudioProgressDataSource {
  Future<AudioStreamModel> getAudioProgress();
}

class QuranAudioProgressDataSource implements IQuranAudioProgressDataSource {
  IAudioPlayer audioService;

  QuranAudioProgressDataSource({
    required this.audioService,
  });

  @override
  Future<AudioStreamModel> getAudioProgress() {
    return audioService.streamPosition();
  }
}
