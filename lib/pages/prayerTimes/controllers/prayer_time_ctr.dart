import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zad_almumin/constents/my_texts.dart';
import '../../../constents/constents.dart';
import '../../../moduls/enums.dart';
import '../../alarms/controllers/alarms_ctr.dart';

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
  Position? _currentPosition;
  PrayerTimeCtr() {
    updatePrayerTimes();
  }
  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Future.delayed(Duration(seconds: 5));
      await Get.dialog(AlertDialog(
        title: MyTexts.settingsTitle(title: "تشغيل خدمات الموقع الجغرافي"),
        content: MyTexts.settingsContent(
            title:
                "يجمع زاد المؤمن بيانات الموقع الجغرافي  لتحديد مواقيت الصلاة الخاصة بك حتى إذا كان التطبيق مغلقًا أو لم يكن قيد الاستخدام"),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              await Geolocator.openLocationSettings();
              serviceEnabled = await Geolocator.isLocationServiceEnabled();
            },
            child: MyTexts.normal(title: "حسنا"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: MyTexts.normal(title: "رفض"),
          ),
        ],
      ));
    }
    if (!serviceEnabled) return null;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Future.delayed(Duration(seconds: 5));
      await Get.dialog(AlertDialog(
        title: MyTexts.settingsTitle(title: "طلب الاذن بالوصول للموقع الحالي"),
        content: MyTexts.settingsContent(
            title:
                "يجمع زاد المؤمن بيانات الموقع الجغرافي  لتحديد مواقيت الصلاة الخاصة بك حتى إذا كان التطبيق مغلقًا أو لم يكن قيد الاستخدام"),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              //Geolocator.openLocationSettings();
              permission = await Geolocator.requestPermission();
            },
            child: MyTexts.normal(title: "حسنا"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: MyTexts.normal(title: "رفض"),
          ),
        ],
      ));

      if (permission == LocationPermission.denied) return null; // Future.error('Location permissions are denied');
    }

    // Permissions are denied forever, handle appropriately.
    if (permission == LocationPermission.deniedForever)
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');

    return await Geolocator.getCurrentPosition();
  }

  updatePrayerTimes({DateTime? newTime}) async {
    curerntDate.value = newTime ?? DateTime.now();
    isLoading.value = true;
    await _getCurrentPosition();
    if (_currentPosition == null) return;
    await _getPrayTimes();
    if (newTime == null) updatePrayerAlarms(); //just in current day

    // await _setPrayTimes();
    checkAndSetNextPrayTime();
    updateCurrentTime();
    isLoading.value = false;
  }

  _getCurrentPosition() async => _currentPosition = await _determinePosition();

  Future _getPrayTimes() async {
    String api = _getApi();
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "لا يوجد اتصال بالانترنت");
      return;
    } else {
      try {
        http.Response responce = await http.get(Uri.parse(api));
        fajrTime.value = _getPrayTimeData(jsonDecode(responce.body), 'Fajr');
        sunTime.value = _getPrayTimeData(jsonDecode(responce.body), 'Sunrise');
        duhrTime.value = _getPrayTimeData(jsonDecode(responce.body), 'Dhuhr');
        asrTime.value = _getPrayTimeData(jsonDecode(responce.body), 'Asr');
        maghribTime.value = _getPrayTimeData(jsonDecode(responce.body), 'Maghrib');
        ishaTime.value = _getPrayTimeData(jsonDecode(responce.body), 'Isha');
      } catch (e) {
        // ignore: avoid_print
        print('ERROR:::: NO INTERNET... ON GET  ADHAN TİMES');
      }
    }
  }

  String _getApi() {
    return 'http://api.aladhan.com/v1/calendar?latitude=${_currentPosition!.latitude}&longitude=${_currentPosition!.longitude}&method=${13}&month=${curerntDate.value.month}&year=${curerntDate.value.year}';
  }

  Time _getPrayTimeData(Map map, String prayName) {
    int hour = int.parse(map['data'][curerntDate.value.day - 1]['timings'][prayName].split(' ')[0].split(':')[0]);
    int minute = int.parse(map['data'][curerntDate.value.day - 1]['timings'][prayName].split(' ')[0].split(':')[1]);
    return Time(hour, minute);
  }

  updatePrayerAlarms() {
    Get.find<AlarmsCtr>().setPrayTimesAlarms(
      fajrTime: fajrTime.value,
      sunTime: sunTime.value,
      duhrTime: duhrTime.value,
      asrTime: asrTime.value,
      maghribTime: maghribTime.value,
      ishaTime: ishaTime.value,
    );
  }

  bool compareTimes(Time time1, Time time2) {
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
      DateTime.now().day,
      time2.hour,
      time2.minute,
      time1.second,
    );

    Duration fiffrenc = t1.difference(t2);
    if (fiffrenc.inSeconds > 0)
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
        nextPrayType.value == PrayerTimeType.fajr ? DateTime.now().add(Duration(days: 1)).day : DateTime.now().day,
        nextPrayTime.value.hour,
        nextPrayTime.value.minute,
        nextPrayTime.value.second,
      ),
      DateTime.now(),
    );

    String houreTimeLeftTxt = Constants.formatInt2.format(leftTime.hour);
    String minuteTimeLeftTxt = Constants.formatInt2.format(leftTime.minute);
    String secondTimeLeftTxt = Constants.formatInt2.format(leftTime.second);

    timeLeftToNextPrayTime.value = '$houreTimeLeftTxt:$minuteTimeLeftTxt:$secondTimeLeftTxt';
    if (leftTime.hour == 0 && leftTime.minute == 0 && leftTime.second == 0) checkAndSetNextPrayTime();

    if (leftTime.hour == 0 &&
        leftTime.minute == Get.find<AlarmsCtr>().distanceBetweenAlarmAndAzan &&
        leftTime.second == 0) {
      Get.find<AlarmsCtr>().setAzanAlarm(nextPrayType: nextPrayType.value);
    }

    updateCurrentTime();
  }

  Time differenceTimes(DateTime time1, DateTime time2) {
    int hour = time1.difference(time2).inHours;
    int minute = time1.difference(time2).inMinutes - (hour * 60);
    int second = time1.difference(time2).inSeconds - (hour * 60 * 60) - (minute * 60);

    if (hour < 0) hour = hour * -1;
    if (minute < 0) minute = minute * -1;
    if (second < 0) second = second * -1;
    return Time(hour, minute, second);
  }

  void checkAndSetNextPrayTime() {
    if (compareTimes(currentTime, ishaTime.value))
      setNextPrayTime(prayTimeType: PrayerTimeType.fajr);
    else if (compareTimes(currentTime, maghribTime.value))
      setNextPrayTime(prayTimeType: PrayerTimeType.isha);
    else if (compareTimes(currentTime, asrTime.value))
      setNextPrayTime(prayTimeType: PrayerTimeType.maghrib);
    else if (compareTimes(currentTime, duhrTime.value))
      setNextPrayTime(prayTimeType: PrayerTimeType.asr);
    else if (compareTimes(currentTime, sunTime.value))
      setNextPrayTime(prayTimeType: PrayerTimeType.duhr);
    else if (compareTimes(currentTime, fajrTime.value)) setNextPrayTime(prayTimeType: PrayerTimeType.sun);
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
}
