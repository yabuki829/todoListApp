import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/models/todo/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:todoapp/models/user/user.dart';

part 'todolist_notifier.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  @override
  List<Todo> build() {
    _loadTodos();
    return [];
  }

  // List<Todo> build() {
  //   return [
  //     const Todo(
  //         id: 1,
  //         title: "Todoアプリを完成させる",
  //         isDone: false,
  //         user: User(id: 1, username: "test"),
  //         isPremium: false),
  //     const Todo(
  //         id: 2,
  //         title: "資格の勉強をする",
  //         isDone: false,
  //         user: User(id: 1, username: "test"),
  //         isPremium: false)
  //   ];
  // }

  TodoListNotifier() : super() {
    _loadTodos();
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

  Future<void> addTodo(String title) async {
    // とりあえずテストユーザーを使う
    final newTodo = Todo(
        id: state.length + 1,
        title: title,
        isDone: false,
        user: const User(id: 1, username: "test"),
        isPremium: false);
    state = [...state, newTodo];
    _saveTodos();
  }

  void updateTodo(Todo updatedTodo) {
    state = [
      for (final todo in state)
        if (todo.id == updatedTodo.id) updatedTodo else todo
    ];
    _saveTodos();
  }

  void deleteTodo(int id) {
    state = state.where((todo) => todo.id != id).toList();
    _saveTodos();
  }

  Todo getTodo(int id) {
    return state.firstWhere((todo) => todo.id == id);
  }
}
