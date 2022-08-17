import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../moduls/enums.dart';
import '../../alarmsPage/controllers/alarm_page_ctr.dart';

class PrayerTimeCtr extends GetxController {
  Rx<PrayerTimeType> nextPrayType = PrayerTimeType.fajr.obs;
  Rx<Time> fajrTime = Time().obs;
  Rx<Time> sunTime = Time().obs;
  Rx<Time> duhrTime = Time().obs;
  Rx<Time> asrTime = Time().obs;
  Rx<Time> maghribTime = Time().obs;
  Rx<Time> ishaTime = Time().obs;
  RxBool isLoading = false.obs;
  RxString nextPrayName = 'موعد الصلاة القادمة'.obs;
  RxString timeLeftToNextPrayTime = '00:00:00'.obs;
  Rx<Time> nextPrayTime = Time().obs;
  Time currentTime = Time(DateTime.now().hour, DateTime.now().minute);
  Rx<DateTime> curerntDate = DateTime.now().obs;
  late Position _currentPosition;
  PrayerTimeCtr() {
    updatePrayerTimes();
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('Location services are disabled.');

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return Future.error('Location permissions are denied');
    }

    // Permissions are denied forever, handle appropriately.
    if (permission == LocationPermission.deniedForever)
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');

    return await Geolocator.getCurrentPosition();
  }

  updatePrayerTimes({DateTime? newTime}) async {
    // newTime ??= DateTime.now();
    // currentTime=Time(newTime.hour, newTime.minute);
    curerntDate.value = newTime ?? DateTime.now();
    isLoading.value = true;
    await _setCurrentPosition();
    await _setPrayTimes();
    if (newTime == null) {
      updatePrayerAlarms();
    }
    // await _setPrayTimes();
    checkNextPrayTime();
    updateCurrentTime();
    isLoading.value = false;
  }

  Time differenceTimes(DateTime time1, DateTime time2) {
    // double dTime1 = time1.hour.toDouble() + (time1.minute.toDouble() / 60) + (time1.second.toDouble() / (60 * 60));
    // double dTime2 = time2.hour.toDouble() + (time2.minute.toDouble() / 60) + (time2.second.toDouble() / (60 * 60));

    // double timeDiff = dTime1 - dTime2;
    // //TODO fix time after isha
    // int hr = timeDiff.truncate();
    // double minute = (timeDiff - timeDiff.truncate()) * 60;
    // double second = (minute - minute.truncate()) * 60;
    // // print('minute $minute');
    // // print('second $second');
    // // return Time(hr, minute.toInt(), second.toInt());
    // return Time(hr, minute.toInt(), second.toInt());

    int hr = time1.difference(time2).inHours;
    int minute = time1.difference(time2).inMinutes - (hr * 60);
    int second = time1.difference(time2).inSeconds - (hr * 60 * 60) - (minute * 60);
    if (hr < 0) hr = 0;
    if (minute < 0) minute = 0;
    if (second < 0) second = 0;
    return Time(hr, minute, second);
  }

  bool compareTimes(Time time1, Time time2) {
    double dTime1 = time1.hour.toDouble() + (time1.minute.toDouble() / 60);
    double dTime2 = time2.hour.toDouble() + (time2.minute.toDouble() / 60);

    double dcompare = dTime1 - dTime2;

    if (dcompare > 0)
      return true;
    else
      return false;
  }

  updateCurrentTime() async {
    await Future.delayed(Duration(seconds: 1));
    Time leftTime = differenceTimes(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        nextPrayTime.value.hour,
        nextPrayTime.value.minute,
        nextPrayTime.value.second,
      ),
      DateTime.now(),
    );

    String houreTimeLeftTxt = leftTime.hour < 10 ? '0${leftTime.hour}' : '${leftTime.hour}';
    String minuteTimeLeftTxt = leftTime.minute < 10 ? '0${leftTime.minute}' : '${leftTime.minute}';
    String secondTimeLeftTxt = leftTime.second < 10 ? '0${leftTime.second}' : '${leftTime.second}';

    timeLeftToNextPrayTime.value = '$houreTimeLeftTxt:$minuteTimeLeftTxt:$secondTimeLeftTxt';
    if (leftTime.hour == 0 && leftTime.minute == 0 && leftTime.second == 0) checkNextPrayTime();
    updateCurrentTime();
  }

  void checkNextPrayTime() {
    Time fajr = Time(fajrTime.value.hour, fajrTime.value.minute);
    Time sun = Time(sunTime.value.hour, sunTime.value.minute);
    Time duhr = Time(duhrTime.value.hour, duhrTime.value.minute);
    Time asr = Time(asrTime.value.hour, asrTime.value.minute);
    Time maghrib = Time(maghribTime.value.hour, maghribTime.value.minute);
    Time isha = Time(ishaTime.value.hour, ishaTime.value.minute);

    if (compareTimes(currentTime, isha))
      setNextPrayTime(prayTimeType: PrayerTimeType.fajr);
    else if (compareTimes(currentTime, maghrib))
      setNextPrayTime(prayTimeType: PrayerTimeType.isha);
    else if (compareTimes(currentTime, asr))
      setNextPrayTime(prayTimeType: PrayerTimeType.maghrib);
    else if (compareTimes(currentTime, duhr))
      setNextPrayTime(prayTimeType: PrayerTimeType.asr);
    else if (compareTimes(currentTime, sun))
      setNextPrayTime(prayTimeType: PrayerTimeType.duhr);
    else if (compareTimes(currentTime, fajr)) setNextPrayTime(prayTimeType: PrayerTimeType.sun);
  }

  setNextPrayTime({required PrayerTimeType prayTimeType}) {
    if (prayTimeType == PrayerTimeType.fajr) {
      nextPrayTime.value = Time(fajrTime.value.hour, fajrTime.value.minute);
      nextPrayName.value = 'الفجر';
      nextPrayType = PrayerTimeType.fajr.obs;
    } else if (prayTimeType == PrayerTimeType.sun) {
      nextPrayTime.value = Time(sunTime.value.hour, sunTime.value.minute);
      nextPrayName.value = 'شروق الشمس';
      nextPrayType = PrayerTimeType.sun.obs;
    } else if (prayTimeType == PrayerTimeType.duhr) {
      nextPrayTime.value = Time(duhrTime.value.hour, duhrTime.value.minute);
      nextPrayName.value = 'الظهر';
      nextPrayType = PrayerTimeType.duhr.obs;
    } else if (prayTimeType == PrayerTimeType.asr) {
      nextPrayTime.value = Time(asrTime.value.hour, asrTime.value.minute);
      nextPrayName.value = 'العصر';
      nextPrayType = PrayerTimeType.asr.obs;
    } else if (prayTimeType == PrayerTimeType.maghrib) {
      nextPrayTime.value = Time(maghribTime.value.hour, maghribTime.value.minute);
      nextPrayName.value = 'المغرب';
      nextPrayType = PrayerTimeType.maghrib.obs;
    } else if (prayTimeType == PrayerTimeType.isha) {
      nextPrayTime.value = Time(ishaTime.value.hour, ishaTime.value.minute);
      nextPrayName.value = 'العشاء';
      nextPrayType = PrayerTimeType.isha.obs;
    }
  }

  _setCurrentPosition() async => _currentPosition = await _determinePosition();

  String _getApi() {
    return 'http://api.aladhan.com/v1/calendar?latitude=${_currentPosition.latitude}&longitude=${_currentPosition.longitude}&method=${13}&month=${curerntDate.value.month}&year=${curerntDate.value.year}';
  }

  Future _setPrayTimes() async {
    String api = _getApi();
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "لا يوجد اتصال بالانترنت");
      return;
    } else {
      try {
        http.Response responce = await http.get(Uri.parse(api));
        fajrTime.value = _getPrayTime(jsonDecode(responce.body), 'Fajr');
        sunTime.value = _getPrayTime(jsonDecode(responce.body), 'Sunrise');
        duhrTime.value = _getPrayTime(jsonDecode(responce.body), 'Dhuhr');
        asrTime.value = _getPrayTime(jsonDecode(responce.body), 'Asr');
        maghribTime.value = _getPrayTime(jsonDecode(responce.body), 'Maghrib');
        ishaTime.value = _getPrayTime(jsonDecode(responce.body), 'Isha');
      } catch (e) {
        // ignore: avoid_print
        print('ERROR:::: NO INTERNET... ON GET  ADHAN TİMES');
      }
    }
  }

  Time _getPrayTime(Map map, String prayName) {
    int hour = int.parse(map['data'][curerntDate.value.day - 1]['timings'][prayName].split(' ')[0].split(':')[0]);
    int minute = int.parse(map['data'][curerntDate.value.day - 1]['timings'][prayName].split(' ')[0].split(':')[1]);
    return Time(hour, minute);
  }

  updatePrayerAlarms() {
    Get.find<AlarmsCtr>().setPrayTimesAlarms(
      fajrTime: Time(fajrTime.value.hour, fajrTime.value.minute),
      sunTime: sunTime.value,
      duhrTime: Time(duhrTime.value.hour, duhrTime.value.minute),
      asrTime: Time(asrTime.value.hour, asrTime.value.minute),
      maghribTime: Time(maghribTime.value.hour, maghribTime.value.minute),
      ishaTime: Time(ishaTime.value.hour, ishaTime.value.minute),
    );
  }
}
