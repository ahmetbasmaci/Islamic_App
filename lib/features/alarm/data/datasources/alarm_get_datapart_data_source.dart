import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/packages/local_storage/local_storage.dart';
import 'package:zad_almumin/core/utils/storage_keys.dart';
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
  void updateAlarmModel(AlarmModel alarmModel);
}

class AlarmGetDatapartDataSource implements IAlarmGetDatapartDataSource {
  ILocalStorage localStorage;
  AlarmGetDatapartDataSource({required this.localStorage}) {
    Map<String, dynamic> alarmActiveMap = localStorage.read(StorageKeys.allAlarmParts) ?? {};
    //alarmActiveMap = {};
    _allAlarmParts = [
      AlarmPartModel(
        title: AppStrings.of(Constants.context).duaTitleAlarm,
        aLarmType: ALarmPart.dua,
        imagePath: AppImages.phalastine,
        alarmModels: [
          RepeatedAlarmModel(
            title: AppStrings.of(Constants.context).duaForPhalastinePeople,
            repeatAlarmType: RepeatAlarmType.values.firstWhere(
              (element) =>
                  element.name ==
                  (alarmActiveMap[AlarmType.duaPhalastine.name]?['repeatAlarmType'] ?? RepeatAlarmType.high.name),
            ),
            isActive: alarmActiveMap[AlarmType.duaPhalastine.name]?['isActive'] ?? true,
            alarmType: AlarmType.duaPhalastine,
          )
        ],
      ),
      AlarmPartModel(
        title: AppStrings.of(Constants.context).hadithTitleAlarm,
        aLarmType: ALarmPart.hadith,
        imagePath: AppImages.hadithAlarm,
        alarmModels: [
          RepeatedAlarmModel(
            title: AppStrings.of(Constants.context).provetMuhammedHadith,
            repeatAlarmType: RepeatAlarmType.values.firstWhere(
              (element) =>
                  element.name ==
                  (alarmActiveMap[AlarmType.hadith.name]?['repeatAlarmType'] ?? RepeatAlarmType.high.name),
            ),
            isActive: alarmActiveMap[AlarmType.hadith.name]?['isActive'] ?? true,
            alarmType: AlarmType.hadith,
          )
        ],
      ),
      AlarmPartModel(
        title: AppStrings.of(Constants.context).dailyAzkarTitleAlarm,
        aLarmType: ALarmPart.dailyAzkar,
        imagePath: AppImages.azkar,
        alarmModels: [
          RepeatedAlarmModel(
            title: AppStrings.of(Constants.context).diferentAzkar,
            repeatAlarmType: RepeatAlarmType.values.firstWhere(
              (element) =>
                  element.name ==
                  (alarmActiveMap[AlarmType.diferentAzkar.name]?['repeatAlarmType'] ?? RepeatAlarmType.high.name),
            ),
            isActive: alarmActiveMap[AlarmType.diferentAzkar.name]?['isActive'] ?? true,
            alarmType: AlarmType.diferentAzkar,
          ),
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).morningZikr,
            alarmPeriod: ALarmPeriod.daily,
            isActive: alarmActiveMap[AlarmType.morningAzkar.name]?['isActive'] ?? true,
            alarmType: AlarmType.morningAzkar,
            time: alarmActiveMap[AlarmType.morningAzkar.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 7, minute: 0),
          ),
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).eveningZikr,
            alarmPeriod: ALarmPeriod.daily,
            isActive: alarmActiveMap[AlarmType.eveningAzkar.name]?['isActive'] ?? true,
            alarmType: AlarmType.eveningAzkar,
            time: alarmActiveMap[AlarmType.eveningAzkar.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 18, minute: 0),
          ),
        ],
      ),
      AlarmPartModel(
        title: AppStrings.of(Constants.context).quranTitleAlarm,
        aLarmType: ALarmPart.quran,
        imagePath: AppImages.quran,
        alarmModels: [
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).readQueanPageEveryday,
            alarmPeriod: ALarmPeriod.daily,
            isActive: alarmActiveMap[AlarmType.quranPageEveryDay.name]?['isActive'] ?? true,
            alarmType: AlarmType.quranPageEveryDay,
            time: alarmActiveMap[AlarmType.quranPageEveryDay.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 12, minute: 0),
          ),
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).readKahfSura,
            alarmPeriod: ALarmPeriod.weekly,
            isActive: alarmActiveMap[AlarmType.quranKahfSure.name]?['isActive'] ?? true,
            alarmType: AlarmType.quranKahfSure,
            time: alarmActiveMap[AlarmType.quranKahfSure.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 9, minute: 0),
          ),
        ],
      ),
      AlarmPartModel(
        title: AppStrings.of(Constants.context).fastTitleAlarm,
        aLarmType: ALarmPart.fast,
        imagePath: AppImages.fast,
        alarmModels: [
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).mondayFasting,
            alarmPeriod: ALarmPeriod.weekly,
            isActive: alarmActiveMap[AlarmType.mondayFasting.name]?['isActive'] ?? true,
            alarmType: AlarmType.mondayFasting,
            time: alarmActiveMap[AlarmType.mondayFasting.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 20, minute: 0),
          ),
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).thursdayFasting,
            alarmPeriod: ALarmPeriod.weekly,
            isActive: alarmActiveMap[AlarmType.thursdayFasting.name]?['isActive'] ?? true,
            alarmType: AlarmType.thursdayFasting,
            time: alarmActiveMap[AlarmType.thursdayFasting.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 20, minute: 0),
          ),
        ],
      ),
      AlarmPartModel(
        title: AppStrings.of(Constants.context).azhanTimeTitleAlarm,
        aLarmType: ALarmPart.pray,
        imagePath: AppImages.pray,
        alarmModels: [
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).fajrPray,
            alarmPeriod: ALarmPeriod.daily,
            isActive: alarmActiveMap[AlarmType.fajrAdhan.name]?['isActive'] ?? true,
            alarmType: AlarmType.fajrAdhan,
            time: alarmActiveMap[AlarmType.fajrAdhan.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 0, minute: 0),
          ),
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).duhrPray,
            alarmPeriod: ALarmPeriod.daily,
            isActive: alarmActiveMap[AlarmType.duhrAdhan.name]?['isActive'] ?? true,
            alarmType: AlarmType.duhrAdhan,
            time: alarmActiveMap[AlarmType.duhrAdhan.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 0, minute: 0),
          ),
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).asrPray,
            alarmPeriod: ALarmPeriod.daily,
            isActive: alarmActiveMap[AlarmType.asrAdhan.name]?['isActive'] ?? true,
            alarmType: AlarmType.asrAdhan,
            time: alarmActiveMap[AlarmType.asrAdhan.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 0, minute: 0),
          ),
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).maghripPray,
            alarmPeriod: ALarmPeriod.daily,
            isActive: alarmActiveMap[AlarmType.maghribAdhan.name]?['isActive'] ?? true,
            alarmType: AlarmType.maghribAdhan,
            time: alarmActiveMap[AlarmType.maghribAdhan.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 0, minute: 0),
          ),
          PeriodicAlarmModel(
            title: AppStrings.of(Constants.context).ishaPray,
            alarmPeriod: ALarmPeriod.daily,
            isActive: alarmActiveMap[AlarmType.ishaAdhan.name]?['isActive'] ?? true,
            alarmType: AlarmType.ishaAdhan,
            time: alarmActiveMap[AlarmType.ishaAdhan.name]?['time']?.toString().toTimeOfDay ??
                TimeOfDay(hour: 0, minute: 0),
          ),
        ],
      ),
    ];
  }
  late List<AlarmPartModel> _allAlarmParts;

  @override
  AlarmPartModel get getDuaAlarmPartData => _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmPart.dua);
  @override
  AlarmPartModel get getHadithAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmPart.hadith);
  @override
  AlarmPartModel get getDailyAzkarAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmPart.dailyAzkar);
  @override
  AlarmPartModel get getQuranAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmPart.quran);
  @override
  AlarmPartModel get getFastAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmPart.fast);
  @override
  AlarmPartModel get getPrayAlarmPartData =>
      _allAlarmParts.firstWhere((element) => element.aLarmType == ALarmPart.pray);

  @override
  void updateAlarmModel(AlarmModel newAlarmModel) {
    bool elementFounded = false;
    for (var alarmPartModel in _allAlarmParts) {
      if (elementFounded) break;
      for (var alarmModel in alarmPartModel.alarmModels) {
        if (alarmModel.alarmType.name == newAlarmModel.alarmType.name) {
          int oldElementIndex = alarmPartModel.alarmModels.indexOf(alarmModel);
          alarmPartModel.alarmModels.remove(alarmModel);
          alarmPartModel.alarmModels.insert(oldElementIndex, newAlarmModel);
          elementFounded = true;
          break;
        }
      }
    }
    Map<String, dynamic> allAlarmPartsMap = {};
    for (var alarmPartModel in _allAlarmParts) {
      for (var alarmModel in alarmPartModel.alarmModels) {
        Map<String, dynamic> alarmModelsMap = {'isActive': alarmModel.isActive};

        if (alarmModel is PeriodicAlarmModel) {
          alarmModelsMap.addAll({
            'time': alarmModel.time.formated,
            'alarmPeriod': alarmModel.alarmPeriod.name,
          });
        } else if (alarmModel is RepeatedAlarmModel) {
          alarmModelsMap.addAll({
            'repeatAlarmType': alarmModel.repeatAlarmType.name,
          });
        }
        allAlarmPartsMap.addAll({alarmModel.alarmType.name: alarmModelsMap});
      }
    }

    localStorage.write(StorageKeys.allAlarmParts, allAlarmPartsMap);
  }
}
