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
    // return const [TabTodo(id: "", title: "タイトル", todos: [])];
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

    _saveTabs();
  }

// tabの削除
  Future<void> delete({required String tabId}) async {
    state = state.where((tab) => tab.id != tabId).toList();
    _saveTabs();
  }

  // Todosの取得
  Future<TabTodo> getTabTodo(
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

  Todo getTodo({required String tabId, required String todoId}) {
    _loadTabs();
    for (TabTodo tab in state) {
      if (tab.id == tabId) {
        for (Todo todo in tab.todos) {
          if (todo.id == todoId) {
            return todo;
          }
        }
        break;
      }
    }
    return Todo(
        id: "",
        title: "",
        isDone: false,
        createdAt: DateTime.now(),
        deadline: DateTime.now(),
        comments: const []);
  }

  // Todoの削除
  Future<void> deleteTodo(
      {required String tabId, required String todoId}) async {
    _loadTabs();
    print("Todoを削除します1");
    state = state.map((tab) {
      if (tab.id == tabId) {
        print("見つかりました。");
        print(tab.title);
        print(tab.todos.where((todo) => todo.id == todoId).toList());
        return tab.copyWith(
            todos: tab.todos.where((todo) => todo.id != todoId).toList());
      }
      return tab;
    }).toList();
    _saveTabs();
    print("Todoを削除完了");
  }

  // Todoの追加
  Future<void> addTodo(
      {required String tabId,
      required String title,
      required DateTime deadline}) async {
    List<TabTodo> updatedState = List.from(state);

    int tabIndex = updatedState.indexWhere((tab) => tab.id == tabId);

    if (tabIndex != -1) {
      final todo = Todo(
          id: generateNonce(),
          title: title,
          isDone: false,
          createdAt: DateTime.now(),
          deadline: deadline,
          comments: []);

      updatedState[tabIndex] = updatedState[tabIndex]
          .copyWith(todos: [...updatedState[tabIndex].todos, todo]);

      state = updatedState;

      _saveTabs();
    }
  }

  void deleteTab(String tabId) {
    state = state.where((tab) => tab.id != tabId).toList();
    _saveTabs();
  }
}

//flutter pub run build_runner build --delete-conflicting-outputs
