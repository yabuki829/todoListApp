import 'package:freezed_annotation/freezed_annotation.dart';

part "comment.freezed.dart";
part "comment.g.dart";

@freezed
class Comment with _$Comment {
  // プロパティを指定
  const factory Comment({
    required String todoId,
    required String id,
    required String text,
    required DateTime createdAt,
    // required User user,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

// flutter pub run build_runner build
