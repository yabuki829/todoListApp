import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/models/todo/todo.dart';

part "tab_todo.freezed.dart";
part "tab_todo.g.dart";

@freezed
class TabTodo with _$TabTodo {
  // プロパティを指定
  const factory TabTodo({
    required String id,
    required String title,
    required List<Todo> todos,
    @Default(0) int priority,
  }) = _TabTodo;

  factory TabTodo.fromJson(Map<String, dynamic> json) =>
      _$TabTodoFromJson(json);
}

// flutter pub run build_runner build