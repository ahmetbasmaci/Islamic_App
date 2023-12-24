import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../pray_times.dart';

class CurrentDayPrayDetailesModel {
  final String gregorianDate;
  final String hijriDate;
  final WeekDays dayName;
  final PrayTimeModel fajrTimeModel;
  final PrayTimeModel sunTimeModel;
  final PrayTimeModel duhrTimeModel;
  final PrayTimeModel asrTimeModel;
  final PrayTimeModel maghripTimeModel;
  final PrayTimeModel ishaTimeModel;

  CurrentDayPrayDetailesModel({
    required this.gregorianDate,
    required this.hijriDate,
    required this.fajrTimeModel,
    required this.sunTimeModel,
    required this.duhrTimeModel,
    required this.asrTimeModel,
    required this.maghripTimeModel,
    required this.ishaTimeModel,
    required this.dayName,
  });

  CurrentDayPrayDetailesModel.fromPraiesInDayModel(PraiesInDayModel praiesInDayModel)
      : gregorianDate = praiesInDayModel.gregorianDate,
        hijriDate = praiesInDayModel.hijriDate,
        dayName = WeekDays.values.firstWhere(
          (element) => element.name.toLowerCase() == praiesInDayModel.dayName.toLowerCase(),
        ),
        fajrTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.fajr,
          time: praiesInDayModel.fajrTime.apiTimeStringToTimeModel,
          isNextPray: false,
        ),
        sunTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.sun,
          time: praiesInDayModel.sunTime.apiTimeStringToTimeModel,
          isNextPray: false,
        ),
        duhrTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.duhr,
          time: praiesInDayModel.duhrTime.apiTimeStringToTimeModel,
          isNextPray: false,
        ),
        asrTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.asr,
          time: praiesInDayModel.asrTime.apiTimeStringToTimeModel,
          isNextPray: false,
        ),
        maghripTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.maghrib,
          time: praiesInDayModel.maghribTime.apiTimeStringToTimeModel,
          isNextPray: false,
        ),
        ishaTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.isha,
          time: praiesInDayModel.ishaTime.apiTimeStringToTimeModel,
          isNextPray: false,
        );

  CurrentDayPrayDetailesModel.empty()
      : gregorianDate = '00:00:00',
        hijriDate = '00:00:00',
        dayName = WeekDays.none,
        fajrTimeModel = PrayTimeModel.empty(),
        sunTimeModel = PrayTimeModel.empty(),
        duhrTimeModel = PrayTimeModel.empty(),
        asrTimeModel = PrayTimeModel.empty(),
        maghripTimeModel = PrayTimeModel.empty(),
        ishaTimeModel = PrayTimeModel.empty();
}
