import '../../../../config/local/l10n.dart';
import '../../../../core/utils/constants.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/resources/resources.dart';
import '../models/alarm_model.dart';
import '../models/alarm_part_model.dart';

abstract class IAlarmGetDatapartDataSource {
  AlarmPartModel get getDuaAlarmPartData;
  AlarmPartModel get getHadithAlarmPartData;
  AlarmPartModel get getDailyAzkarAlarmPartData;
  AlarmPartModel get getQuranAlarmPartData;
  AlarmPartModel get getFastAlarmPartData;
  AlarmPartModel get getPrayAlarmPartData;
}

class AlarmGetDatapartDataSource implements IAlarmGetDatapartDataSource {
  final List<AlarmPartModel> _allAlarmParts = [
    AlarmPartModel(
      title: AppStrings.of(Constants.context).duaTitleAlarm,
      aLarmType: ALarmType.dua,
      imagePath: AppImages.phalastine,
      alarmModels: [
        RepeatedAlarmModel(
          title: AppStrings.of(Constants.context).duaForPhalastinePeople,
          repeatAlarmType: RepeatAlarmType.high,
          isActive: true,
        )
      ],
    ),
    AlarmPartModel(
      title: AppStrings.of(Constants.context).hadithTitleAlarm,
      aLarmType: ALarmType.hadith,
      imagePath: AppImages.hadithAlarm,
      alarmModels: [
        RepeatedAlarmModel(
          title: AppStrings.of(Constants.context).provetMuhammedHadith,
          repeatAlarmType: RepeatAlarmType.high,
          isActive: true,
        )
      ],
    ),
    AlarmPartModel(
      title: AppStrings.of(Constants.context).dailyAzkarTitleAlarm,
      aLarmType: ALarmType.dailyAzkar,
      imagePath: AppImages.azkar,
      alarmModels: [
        RepeatedAlarmModel(
          title: AppStrings.of(Constants.context).diferentAzkar,
          repeatAlarmType: RepeatAlarmType.high,
          isActive: true,
        ),
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).morningZikr,
          aLarmPeriod: ALarmPeriod.daily,
          isActive: true,
        ),
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).eveningZikr,
          aLarmPeriod: ALarmPeriod.daily,
          isActive: true,
        ),
      ],
    ),
    AlarmPartModel(
      title: AppStrings.of(Constants.context).quranTitleAlarm,
      aLarmType: ALarmType.quran,
      imagePath: AppImages.quran,
      alarmModels: [
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).readQueanPageEveryday,
          aLarmPeriod: ALarmPeriod.daily,
          isActive: true,
        ),
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).readKahfSura,
          aLarmPeriod: ALarmPeriod.weekly,
          isActive: true,
        ),
      ],
    ),
    AlarmPartModel(
      title: AppStrings.of(Constants.context).fastTitleAlarm,
      aLarmType: ALarmType.fast,
      imagePath: AppImages.fast,
      alarmModels: [
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).mondayFasting,
          aLarmPeriod: ALarmPeriod.weekly,
          isActive: true,
        ),
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).thursdayFasting,
          aLarmPeriod: ALarmPeriod.weekly,
          isActive: true,
        ),
      ],
    ),
    AlarmPartModel(
      title: AppStrings.of(Constants.context).azhanTimeTitleAlarm,
      aLarmType: ALarmType.pray,
      imagePath: AppImages.pray,
      alarmModels: [
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).fajrPray,
          aLarmPeriod: ALarmPeriod.daily,
          isActive: true,
        ),
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).duhrPray,
          aLarmPeriod: ALarmPeriod.daily,
          isActive: true,
        ),
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).asrPray,
          aLarmPeriod: ALarmPeriod.daily,
          isActive: true,
        ),
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).maghripPray,
          aLarmPeriod: ALarmPeriod.daily,
          isActive: true,
        ),
        PeriodicAlarmModel(
          title: AppStrings.of(Constants.context).ishaPray,
          aLarmPeriod: ALarmPeriod.daily,
          isActive: true,
        ),
      ],
    ),
  ];

  @override
  AlarmPartModel get getDuaAlarmPartData => _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmType.dua);
  @override
  AlarmPartModel get getHadithAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmType.hadith);
  @override
  AlarmPartModel get getDailyAzkarAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmType.dailyAzkar);
  @override
  AlarmPartModel get getQuranAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmType.quran);
  @override
  AlarmPartModel get getFastAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmType.fast);
  @override
  AlarmPartModel get getPrayAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmType.pray);
}
