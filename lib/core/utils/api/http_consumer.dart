import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_consumer.dart';

class HttpConsumer implements ApiConsumer {
  @override
  Future delete(String url, {Map<String, dynamic>? params}) async {
    final response = await http.delete(Uri.parse(url));
    return _handelResponseAsJson(response);
  }

  @override
  Future get(String url, {Map<String, dynamic>? params}) async {
    final response = await http.get(Uri.parse(url));
    return _handelResponseAsJson(response);
  }

  @override
  Future post(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    final response = await http.post(Uri.parse(url), body: body);
    return _handelResponseAsJson(response);
  }

  @override
  Future put(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    final response = await http.put(Uri.parse(url), body: body);
    return _handelResponseAsJson(response);
  }

  dynamic _handelResponseAsJson(http.Response response) {
    return json.decode(response.body);
  }
}
