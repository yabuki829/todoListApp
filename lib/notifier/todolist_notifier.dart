import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/models/comment/comment.dart';
import 'package:todoapp/models/todo/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

part 'todolist_notifier.g.dart';

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
class TodoListNotifier extends _$TodoListNotifier {
  @override
  List<Todo> build() {
    _loadTodos();
    return [];
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString('todos');
    if (todosJson != null) {
      final todosList = (jsonDecode(todosJson) as List)
          .map((item) => Todo.fromJson(item))
          .toList();
      state = todosList;
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = jsonEncode(state.map((todo) => todo.toJson()).toList());
    await prefs.setString('todos', todosJson);
  }

  Future<void> addTodo(
      {required String title, required DateTime deadline}) async {
    final newTodo = Todo(
      id: generateNonce(),
      title: title,
      isDone: false,
      createdAt: DateTime.now(),
      deadline: deadline,
      comments: [],
    );
    state = [...state, newTodo];
    _saveTodos();
  }

  void updateTodo({required Todo updatedTodo}) {
    state = [
      for (final todo in state)
        if (todo.id == updatedTodo.id) updatedTodo else todo
    ];
    _saveTodos();
  }

  void deleteTodo({
    required String id,
  }) {
    state = state.where((todo) => todo.id != id).toList();
    _saveTodos();
  }

  Todo getTodo(String id) {
    _loadTodos();

    return state.firstWhere((todo) => todo.id == id);
  }

  void addComment({required String todoId, required String commentText}) {
    final newComment = Comment(
      id: generateNonce(),
      text: commentText,
      createdAt: DateTime.now(),
    );
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(comments: [...todo.comments, newComment])
        else
          todo
    ];
    _saveTodos();
  }

  void deleteComment({required String todoId, required String commentId}) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(
              comments: todo.comments
                  .where((comment) => comment.id != commentId)
                  .toList())
        else
          todo
    ];
    _saveTodos();
  }
}
//flutter pub run build_runner build --delete-conflicting-outputs
