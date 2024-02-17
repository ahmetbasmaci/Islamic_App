class AudioStreamModel {
  final Duration duration;
  final Stream<Duration> position;

  AudioStreamModel({
    required this.duration,
    required this.position,
  });

  AudioStreamModel.empty()
      : duration = Duration.zero,
        position = const Stream.empty();
}
