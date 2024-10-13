import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/models/tab/tab_todo.dart';
import 'package:todoapp/models/todo/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

part 'tab_notifier.g.dart';

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
class TabNotifier extends _$TabNotifier {
  @override
  List<TabTodo> build() {
    _loadTabs();
    return [];
  }

  Future<void> _loadTabs() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString('tabs');
    if (todosJson != null) {
      final tabList = (jsonDecode(todosJson) as List)
          .map((item) => TabTodo.fromJson(item))
          .toList();

      state = tabList;
    }
  }

  Future<void> _saveTabs() async {
    final prefs = await SharedPreferences.getInstance();
    final tabsJson = jsonEncode(state.map((tab) => tab.toJson()).toList());
    await prefs.setString('tabs', tabsJson);
  }

  Future<void> addTab({required String title}) async {
    final newTab = TabTodo(id: generateNonce(), title: title, todos: []);

    state = [...state, newTab];

    print("タブを保存します");
    print(state);
    _saveTabs();
  }

// tabの削除
  Future<void> delete({required String tabId}) async {
    state = state.where((tab) => tab.id != tabId).toList();
    _saveTabs();
  }

  // Todosの取得
  Future<TabTodo> getTodo(
      {required String tabId, required String todoId}) async {
    _loadTabs();
    var findTab = const TabTodo(id: "", title: "", todos: []);
    for (TabTodo tab in state) {
      if (tab.id == tabId) {
        findTab = tab;
        break;
      }
    }
    return findTab;
  }

  // Todoの削除
  Future<void> deleteTodo(
      {required String tabId, required String todoId}) async {
    _loadTabs();
    for (TabTodo tab in state) {
      if (tab.id == tabId) {
        tab.todos.where((todo) => todo.id != todoId).toList();
        _saveTabs();
        break;
      }
    }

    // Todoの追加
  }

  Future<void> addTodo(
      {required String tabId,
      required String title,
      required DateTime deadline}) async {
    for (int i = 0; i < state.length; i++) {
      if (state[i].id == tabId) {
        final todo = Todo(
            id: generateNonce(),
            title: title,
            isDone: false,
            createdAt: DateTime.now(),
            deadline: deadline,
            comments: []);
        state[i].todos.add(todo);

        _saveTabs();
        break;
      }
    }
    //
  }

  void deleteTab(String tabId) {
    state = state.where((tab) => tab.id != tabId).toList();
    _saveTabs();
  }
}

//flutter pub run build_runner build --delete-conflicting-outputs
