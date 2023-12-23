import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../pray_times.dart';

class CurrentDayPrayDetailesModel {
  final String gregorianDate;
  final String hijriDate;
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
  });

  CurrentDayPrayDetailesModel.fromPraiesInDayModel(PraiesInDayModel praiesInDayModel)
      : gregorianDate = praiesInDayModel.gregorianDate,
        hijriDate = praiesInDayModel.hijriDate,
        fajrTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.fajr,
          time: praiesInDayModel.fajrTime.toTime,
          isNextPray: false,
        ),
        sunTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.sun,
          time: praiesInDayModel.sunTime.toTime,
          isNextPray: false,
        ),
        duhrTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.duhr,
          time: praiesInDayModel.duhrTime.toTime,
          isNextPray: false,
        ),
        asrTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.asr,
          time: praiesInDayModel.asrTime.toTime,
          isNextPray: false,
        ),
        maghripTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.maghrib,
          time: praiesInDayModel.maghribTime.toTime,
          isNextPray: false,
        ),
        ishaTimeModel = PrayTimeModel(
          prayTimeType: PrayTimeType.isha,
          time: praiesInDayModel.ishaTime.toTime,
          isNextPray: false,
        );

  CurrentDayPrayDetailesModel.empty()
      : gregorianDate = '00:00:00',
        hijriDate = '00:00:00',
        fajrTimeModel = PrayTimeModel.empty(),
        sunTimeModel = PrayTimeModel.empty(),
        duhrTimeModel = PrayTimeModel.empty(),
        asrTimeModel = PrayTimeModel.empty(),
        maghripTimeModel = PrayTimeModel.empty(),
        ishaTimeModel = PrayTimeModel.empty();
}
