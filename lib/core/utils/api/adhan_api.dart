import 'package:geolocator/geolocator.dart';

class AdhanApi {
  static const String _baseUrl = 'http://api.aladhan.com/v1/';

  static String calender({
    required Position position,
    required DateTime date,
    int method = 13,
  }) =>
      "${_baseUrl}calendar?latitude=${position.latitude}&longitude=${position.longitude}&method=$method&month=${date.month}&year=${date.year}";
}
