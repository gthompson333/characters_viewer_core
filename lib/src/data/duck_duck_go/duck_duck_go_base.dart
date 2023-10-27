import 'dart:convert';
import 'package:http/http.dart';
import '../network_utils/network_utils.dart';

class DuckDuckGoRemoteBase {
  static const String _baseUrl = "http://api.duckduckgo.com";
  final Client _client;

  DuckDuckGoRemoteBase(this._client);

  Future<Response> request(
      {required RequestAction action,
      required String path,
      dynamic body = Nothing}) async {
    switch (action) {
      case RequestAction.get:
        return _client.get(Uri.parse("$_baseUrl/$path"));
      case RequestAction.post:
        return _client.post(Uri.parse("$_baseUrl/$path"),
            headers: {"Content-Type": "application/json"},
            body: json.encode(body));
      case RequestAction.delete:
        return _client.delete(Uri.parse("$_baseUrl/$path"));
      case RequestAction.put:
        return _client.put(Uri.parse("$_baseUrl/$path"),
            headers: {"Content-Type": "application/json"},
            body: json.encode(body));
    }
  }
}
