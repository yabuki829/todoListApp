import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/comment/comment.dart';
import 'package:todoapp/models/todo/todo.dart';
import 'dart:convert';

import 'package:todoapp/notifier/tab_notifier.dart';

part 'todo_notifier.g.dart';

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
class TodoNotifier extends _$TodoNotifier {
  @override
  List<Todo> build() {
    _loadTodos();
    return [];
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString('todos');

    if (todosJson != null) {
      final todoList = (jsonDecode(todosJson) as List)
          .map((item) => Todo.fromJson(item))
          .toList();
      if (todoList.isEmpty) {
        state = [
          Todo(
              id: "test",
              title: "ダウンロードありがとうございます。",
              isDone: false,
              createdAt: DateTime.now(),
              deadline: DateTime.now(),
              comments: [],
              tabId: "test")
        ];
      } else {
        state = todoList;
      }
    }
  }

  Future<void> add(String title, String tabId, DateTime deadline) async {
    final newTodo = Todo(
        id: generateNonce(),
        title: title,
        isDone: false,
        createdAt: DateTime.now(),
        deadline: deadline,
        comments: [],
        tabId: tabId);

    state = [...state, newTodo];

    await _saveTodos();
  }

  List<Todo> get(String tabId) {
    ref.watch(tabNotifierProvider);
    final todolist = state.where((todo) => todo.tabId == tabId).toList();

    return todolist;
  }

  Todo getById(String todoId) {
    final todo = state.firstWhere((todo) => todo.id == todoId);
    return todo;
  }

  Future<void> delete(String id) async {
    state = state.where((todo) => todo.id != id).toList();

    await _saveTodos();
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = jsonEncode(state.map((todo) => todo.toJson()).toList());
    await prefs.setString('todos', todosJson);
  }
}
