import 'package:freezed_annotation/freezed_annotation.dart';

part "user.freezed.dart";
part "user.g.dart";

@freezed
class User with _$User {
  // プロパティを指定
  const factory User({
    required int id,
    required String username,
    @Default(false) bool isPremium,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}


// flutter pub run build_runner build