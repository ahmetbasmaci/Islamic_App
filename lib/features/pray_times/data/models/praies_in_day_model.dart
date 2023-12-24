class PraiesInDayModel {
  final String gregorianDate;
  final String hijriDate;
  final String fajrTime;
  final String sunTime;
  final String duhrTime;
  final String asrTime;
  final String maghribTime;
  final String ishaTime;
  final String dayName;

  PraiesInDayModel({
    required this.gregorianDate,
    required this.hijriDate,
    required this.fajrTime,
    required this.sunTime,
    required this.duhrTime,
    required this.asrTime,
    required this.maghribTime,
    required this.ishaTime,
    required this.dayName,
  });

  factory PraiesInDayModel.fromJson(Map<String, dynamic> json) {
    var dayData = json['data'];
    var dayDataDate = dayData['date'];
    var dayDataTimings = dayData['timings'];
    return PraiesInDayModel(
      gregorianDate: dayDataDate['gregorian']['date'],
      hijriDate: dayDataDate['hijri']['date'],
      fajrTime: dayDataTimings['Imsak'],
      sunTime: dayDataTimings['Sunrise'],
      duhrTime: dayDataTimings['Dhuhr'],
      asrTime: dayDataTimings['Asr'],
      maghribTime: dayDataTimings['Maghrib'],
      ishaTime: dayDataTimings['Isha'],
      dayName: dayDataDate['gregorian']['weekday']['en'],
    );
  }
}
