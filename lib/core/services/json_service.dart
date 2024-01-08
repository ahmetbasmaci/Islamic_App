import 'dart:convert';

import 'package:flutter/services.dart';

abstract class IJsonService {
  Future<dynamic> readJson(String path);
}

class JsonService extends IJsonService {
  @override
  Future<dynamic> readJson(String path) async {
    String jsonString = await rootBundle.loadString(path);
    dynamic data = json.decode(jsonString);
    return data;
  }
}
