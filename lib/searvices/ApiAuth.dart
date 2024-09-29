import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/searvices/ApiClient.dart';
import 'dart:convert';

class ApiAuth {
  // ログイン機能
  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    print("ログインします");

    final loginData = {
      'email': email,
      'password': password,
    };

    try {
      final response =
          await ApiClient().post("api/auth/jwt/create/", loginData);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final accessToken = responseData['access'];
        final refreshToken = responseData['refresh'];

        // トークンを保存して遷移する

        context.go('/');
      } else {
        print("ログイン失敗: ${response.statusCode}");
      }
    } catch (e) {
      print("エラーが発生しました: $e");
    }
  }

  // サインアップ機能（後で実装）
  void signUp(String email, String password) {
    // サインアップ処理を実装する
  }

  Future<void> getTest() async {
    final response = await ApiClient().get("api/test/");
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData);
    }
  }
}
