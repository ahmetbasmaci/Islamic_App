import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zad_almumin/core/error/exceptions/app_exceptions.dart';
import 'api_consumer.dart';

class HttpConsumer implements ApiConsumer {
  @override
  Future delete(String url, {Map<String, dynamic>? params}) async {
    final response = await http.delete(Uri.parse(url));
    return _handelResponseAsJson(response);
  }

  @override
  Future get(String url, {Map<String, dynamic>? params, bool convertToJson = false}) async {
    final response = await http.get(Uri.parse(url));
    if (convertToJson) {
      return _handelResponseAsJson(response);
    }
    return response;
  }

  @override
  Future post(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    final response = await http.post(Uri.parse(url), body: body);
    return _handelResponseAsJson(response);
  }

  @override
  Future put(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    final response = await http.Client().get(Uri.parse(url));
    final response2 = await http.put(Uri.parse(url), body: body);

    return _handelResponseAsJson(response);
  }

  dynamic _handelResponseAsJson(http.Response response) {
    return json.decode(response.body);
  }

  @override
  Future<http.StreamedResponse> getStream(String url, {Map<String, dynamic>? params}) async {
    var response = await http.Client().send(http.Request('GET', Uri.parse(url)));

    if (response.statusCode == 200) {
      return response;
    }
    throw ServerException('Error while downloading (url) file from server status code: ${response.statusCode}');
  }
}
