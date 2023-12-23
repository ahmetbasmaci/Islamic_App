class Time {
  final int hour;
  final int minute;
  final int second;

  Time({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  Time.empty({
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
  });
}
