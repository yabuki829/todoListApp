import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/models/comment/comment.dart';

part "todo.freezed.dart";
part "todo.g.dart";

@freezed
class Todo with _$Todo {
  // プロパティを指定
  const factory Todo({
    required String tabId,
    required String id,
    required String title,
    required bool isDone,
    required DateTime createdAt,
    required DateTime deadline,
    required List<Comment> comments,
    @Default(0) int priority,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

// flutter pub run build_runner build
