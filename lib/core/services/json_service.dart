import 'dart:convert';

import 'package:flutter/services.dart';

class JsonService {
  JsonService._();
  static Future<dynamic> readJson(String path) async {
    String jsonString = await rootBundle.loadString(path);
    dynamic data = json.decode(jsonString);
    return data;
  }
}
