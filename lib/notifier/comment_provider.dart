import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/comment/comment.dart';
import 'dart:convert';

part 'comment_provider.g.dart';

// ランダムなIDを生成する関数
String generateNonce([int length = 12]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  final randomStr =
      List.generate(length, (_) => charset[random.nextInt(charset.length)])
          .join();
  return randomStr;
}

@riverpod
class CommentNotifier extends _$CommentNotifier {
  @override
  List<Comment> build() {
    _loadComments();
    return [];
  }

  Future<void> _loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final commentsJson = prefs.getString('comments');

    if (commentsJson != null) {
      final commentList = (jsonDecode(commentsJson) as List)
          .map((item) => Comment.fromJson(item))
          .toList();
      state = commentList;
    }
  }

  Future<void> add(
    String text,
    String todoId,
  ) async {
    final newComment = Comment(
      todoId: todoId,
      id: generateNonce(),
      text: text,
      createdAt: DateTime.now(),
    );

    state = [...state, newComment];

    await _saveComments();
  }

  Future<void> _saveComments() async {
    final prefs = await SharedPreferences.getInstance();
    final commentsJson =
        jsonEncode(state.map((comment) => comment.toJson()).toList());
    await prefs.setString('comments', commentsJson);
  }

  Future<void> deleteComment(
      {required String todoId, required String commentId}) async {
    state = state.where((comment) => comment.id != commentId).toList();

    await _saveComments();
  }
}
