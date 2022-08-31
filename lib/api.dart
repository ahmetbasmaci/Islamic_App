// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

//TODO add check for internet
class Api {
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) headers.addAll({'Authorization': 'Bearer $token'});

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    print('---------------\n get method=> \n url: $url \n token:$token \n response: ${response.body}\n---------------');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('error with status code in get method${response.statusCode}');
    }
  }

  Future<dynamic> post({required String url, required dynamic body, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) headers.addAll({'Authorization': 'Bearer $token'});

    http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
    print(
        '---------------\n post method=> \n url: $url \n  token:$token \n response: ${response.body}\n---------------');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'error with status code in pos method${response.statusCode} with body ${json.decode(response.body)}');
    }
  }

  Future<dynamic> put({required String url, required dynamic body, String? token}) async {
    Map<String, String> headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    if (token != null) headers.addAll({'Authorization': 'Bearer $token'});

    http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
    print('---------------\n put method=> \n url: $url \n token:$token \n response: ${response.body}\n---------------');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'error with status code in put method${response.statusCode} with body ${json.decode(response.body)}');
    }
  }
}
