import 'package:geolocator/geolocator.dart';

class AdhanApi {
  AdhanApi._();
  static const String _baseUrl = 'http://api.aladhan.com/v1/';

  static String timings({
    required Position position,
    required DateTime date,
    int method = 16,
  }) =>
      // "${_baseUrl}timings?latitude=${position.latitude}&longitude=${position.longitude}&method=$method&day=${date.day}&month=${date.month}&year=${date.year}";
      "${_baseUrl}timings/${date.day}-${date.month}-${date.year}?latitude=${position.latitude}&longitude=${position.longitude}&method=$method";
}
