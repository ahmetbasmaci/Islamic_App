import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import 'package:zad_almumin/core/utils/params/params.dart';
import '../../../../core/packages/location_detector/location_detector.dart';
import '../../data/models/current_day_pray_detailes_model.dart';
import '../../data/models/pray_time_model.dart';
import '../../data/models/time.dart';
import '../../domain/usecases/get_pray_time_use_case.dart';
part 'pray_times_state.dart';

class PrayTimesCubit extends Cubit<PrayTimesState> {
  final ILocationDetector locationDetector;
  final GetPrayTimeUseCase getPrayTimeseCase;
  PrayTimesCubit({
    required this.locationDetector,
    required this.getPrayTimeseCase,
  }) : super(PrayTimesState.initial());

  DateTime currentPageDate = DateTime.now();

  PrayTimeModel get nextPrayModel {
    if (state.currentDayPrayDetailesModel.fajrTimeModel.isNextPray)
      return state.currentDayPrayDetailesModel.fajrTimeModel;
    else if (state.currentDayPrayDetailesModel.sunTimeModel.isNextPray)
      return state.currentDayPrayDetailesModel.sunTimeModel;
    else if (state.currentDayPrayDetailesModel.duhrTimeModel.isNextPray)
      return state.currentDayPrayDetailesModel.duhrTimeModel;
    else if (state.currentDayPrayDetailesModel.asrTimeModel.isNextPray)
      return state.currentDayPrayDetailesModel.asrTimeModel;
    else if (state.currentDayPrayDetailesModel.maghripTimeModel.isNextPray)
      return state.currentDayPrayDetailesModel.maghripTimeModel;
    else // if(state.currentDayPrayDetailesModel!.ishaTimeModel.isNextPray)
      return state.currentDayPrayDetailesModel.ishaTimeModel;
  }

  String getPrayTimeByType(PrayTimeType prayTimeType) {
    if (state.currentDayPrayDetailesModel.fajrTimeModel.prayTimeType == prayTimeType)
      return state.currentDayPrayDetailesModel.fajrTimeModel.time.timeToString;
    else if (state.currentDayPrayDetailesModel.sunTimeModel.prayTimeType == prayTimeType)
      return state.currentDayPrayDetailesModel.sunTimeModel.time.timeToString;
    else if (state.currentDayPrayDetailesModel.duhrTimeModel.prayTimeType == prayTimeType)
      return state.currentDayPrayDetailesModel.duhrTimeModel.time.timeToString;
    else if (state.currentDayPrayDetailesModel.asrTimeModel.prayTimeType == prayTimeType)
      return state.currentDayPrayDetailesModel.asrTimeModel.time.timeToString;
    else if (state.currentDayPrayDetailesModel.maghripTimeModel.prayTimeType == prayTimeType)
      return state.currentDayPrayDetailesModel.maghripTimeModel.time.timeToString;
    else if (state.currentDayPrayDetailesModel.ishaTimeModel.prayTimeType == prayTimeType)
      return state.currentDayPrayDetailesModel.ishaTimeModel.time.timeToString;
    else
      return '00:00:00';
  }

  Future<void> updateNextdayPrayerTimes() async {
    await _updatePrayerTimes(currentPageDate.add(const Duration(days: 1)));
  }

  Future<void> updatePreviosdayPrayerTimes() async {
    await _updatePrayerTimes(currentPageDate.subtract(const Duration(days: 1)));
  }

  Future<void> updateTodayPrayerTimes() async {
    await _updatePrayerTimes(DateTime.now());
  }

  Future<void> _updatePrayerTimes(DateTime date) async {
    emit(state.copyWith(isLoading: true));

    currentPageDate = date;

    Position? position = await locationDetector.currentPosition;

    if (position == null) return;

    var result = await getPrayTimeseCase.call(GetPrayTimeParams(position: position, date: date));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: 'لا يمكن الحصول على موقعك الحالي\n${failure.message}'));
      },
      (praiesInDayModel) async {
        //TODO  // if (dateParam == null) updatePrayerAlarms(); //just in current day
        emit(
          state.copyWith(
            isLoading: false,
            currentDayPrayDetailesModel: CurrentDayPrayDetailesModel.fromPraiesInDayModel(praiesInDayModel),
          ),
        );
        Time currentTime = Time(hour: date.hour, minute: date.minute, second: date.second);
        _updateNextPrayTime(currentTime);
      },
    );
    _updateCurrentTime();
  }

  void _updateCurrentTime() async {
    await Future.delayed(const Duration(seconds: 1));
    // var alarmCtr = Get.find<AlarmsCtr>();

    if (nextPrayModel.prayTimeType == PrayTimeType.none) {
      emit(state.copyWith(timeLeftToNextPrayTime: '00:00:00'));
      return;
    }

    bool timeToPray = false;

    Time currentTime = Time(
      hour: DateTime.now().hour,
      minute: DateTime.now().minute,
      second: 59 - DateTime.now().second,
    );
    String timeLeftToNextPrayTime = '';
    if (nextPrayModel.prayTimeType == PrayTimeType.fajr) {
      int leftHour = -1;
      int leftMinute = -1;
      if (currentTime.hour < state.currentDayPrayDetailesModel.ishaTimeModel.time.hour) {
        //after 12 o'clock
        leftHour = nextPrayModel.time.hour - currentTime.hour;
        leftMinute = nextPrayModel.time.minute - currentTime.minute;
      } else {
        //before 12 o'clock
        leftHour = nextPrayModel.time.hour + (24 - currentTime.hour);
        leftMinute = nextPrayModel.time.minute - currentTime.minute;
      }
      if (leftMinute < 0) {
        leftHour--;
        leftMinute = 60 + leftMinute;
      }

      timeLeftToNextPrayTime = '${leftHour.formated2}:${leftMinute.formated2}:${currentTime.second.formated2}';
      timeToPray = leftHour == 0 && leftMinute == 0 && currentTime.second == 0;
    } else {
      int leftHour = nextPrayModel.time.hour - currentTime.hour;
      int leftMinute = nextPrayModel.time.minute - currentTime.minute;
      if (leftMinute < 0) {
        leftHour--;
        leftMinute = 60 + leftMinute;
      }

      timeLeftToNextPrayTime = '${leftHour.formated2}:${leftMinute.formated2}:${currentTime.second.formated2}';
      timeToPray = leftHour == 0 && leftMinute == 0 && currentTime.second == 0;
    }
    if (timeToPray) {
      _updateNextPrayTime(currentTime);

      // Get.find<AlarmsCtr>().setAzanAlarm(nextPrayType: nextPrayType.value);
    } else {
      _updateCurrentTime();
    }
    emit(state.copyWith(timeLeftToNextPrayTime: timeLeftToNextPrayTime));
  }

  void _updateNextPrayTime(Time currentTime) {
    if (_compareTimes(currentTime, state.currentDayPrayDetailesModel.fajrTimeModel.time, isFajr: true))
      _setNextPrayTime(state.currentDayPrayDetailesModel.fajrTimeModel);
    else if (_compareTimes(currentTime, state.currentDayPrayDetailesModel.sunTimeModel.time))
      _setNextPrayTime(state.currentDayPrayDetailesModel.sunTimeModel);
    else if (_compareTimes(currentTime, state.currentDayPrayDetailesModel.duhrTimeModel.time))
      _setNextPrayTime(state.currentDayPrayDetailesModel.duhrTimeModel);
    else if (_compareTimes(currentTime, state.currentDayPrayDetailesModel.asrTimeModel.time))
      _setNextPrayTime(state.currentDayPrayDetailesModel.asrTimeModel);
    else if (_compareTimes(currentTime, state.currentDayPrayDetailesModel.maghripTimeModel.time))
      _setNextPrayTime(state.currentDayPrayDetailesModel.maghripTimeModel);
    else if (_compareTimes(currentTime, state.currentDayPrayDetailesModel.ishaTimeModel.time))
      _setNextPrayTime(state.currentDayPrayDetailesModel.ishaTimeModel);
  }

  bool _compareTimes(Time time1, Time time2, {bool isFajr = false}) {
    DateTime t1 = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      time1.hour,
      time1.minute,
      time1.second,
    );
    DateTime t2 = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + ((time1.hour > state.currentDayPrayDetailesModel.ishaTimeModel.time.hour && isFajr) ? 1 : 0),
      time2.hour,
      time2.minute,
      time2.second,
    );

    Duration fiffrenc = t2.difference(t1);
    if (fiffrenc.inSeconds > 0)
      return true;
    else
      return false;
  }

  void _setNextPrayTime(PrayTimeModel prayTimeModel) {
    state.currentDayPrayDetailesModel.fajrTimeModel.isNextPray = false;
    state.currentDayPrayDetailesModel.sunTimeModel.isNextPray = false;
    state.currentDayPrayDetailesModel.duhrTimeModel.isNextPray = false;
    state.currentDayPrayDetailesModel.asrTimeModel.isNextPray = false;
    state.currentDayPrayDetailesModel.maghripTimeModel.isNextPray = false;
    state.currentDayPrayDetailesModel.ishaTimeModel.isNextPray = false;
    prayTimeModel.isNextPray = true;
  }
}
