import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'AuthNotifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  bool build() {
    return false;
  }

  // ログイン処理
  void login(String email, String password) {
    // ログインに成功したらTrueに変更
    state = true;
  }

  // ログアウト処理
  void logout() {
    state = false;
  }
}
