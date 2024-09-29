import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/models/user/user.dart';

part "todo.freezed.dart";
part "todo.g.dart";

@freezed
class Todo with _$Todo {
  // プロパティを指定
  const factory Todo({
    required int id,
    required String title,
    required bool isDone,
    required User user,
    @Default(false) bool isPremium,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

// flutter pub run build_runner build
