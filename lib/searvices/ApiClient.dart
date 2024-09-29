import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final baseURL = "http://127.0.0.1:8000/";

  // GET リクエスト
  Future<http.Response> get(String url) async {
    final fullUrl = Uri.parse(baseURL + url);
    print(fullUrl);

    try {
      final response = await http.get(fullUrl);
      return response;
    } catch (e) {
      throw Exception("GETリクエスト失敗: $e");
    }
  }

  // POST リクエスト
  Future<http.Response> post(String url, Map<String, String> body) async {
    final fullUrl = Uri.parse(baseURL + url);
    print(fullUrl);
    print(jsonEncode(body));

    try {
      final response = await http.post(
        fullUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("POSTリクエスト失敗: $e");
    }
  }
}
