import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  bool build() {
    return false;
  }

  Future<bool> login({required String email, required String password}) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/auth/login/');
    try {
      final response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      switch (response.statusCode) {
        case 200:
          print("ログイン成功");
          return true; // ここでtrueを返す
        case 401:
          throw Exception('ログイン失敗: メールアドレスかパスワードが間違っています');
        case 403:
          throw Exception('ログイン失敗: メールアドレスかパスワードが間違っています');
        default:
          throw Exception('ログイン失敗: ${response.statusCode}');
      }
    } catch (e) {
      print("エラー発生: $e");
      return false;
    }
    // return false; // ここは不要
  }
}
