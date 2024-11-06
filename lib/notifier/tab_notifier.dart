import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/models/tab/tab_todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

import 'package:todoapp/notifier/todo_notifier.dart';

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
    return const [TabTodo(id: "説明書", title: "test")];
  }

  Future<void> _loadTabs() async {
    final prefs = await SharedPreferences.getInstance();
    final tabsJson = prefs.getString('tabs');
    if (tabsJson != null) {
      final tabList = (jsonDecode(tabsJson) as List)
          .map((item) => TabTodo.fromJson(item))
          .toList();
      if (tabList.isEmpty) {
        state = const [TabTodo(id: "test", title: "使い方")];
      } else {
        state = tabList;
      }
    }
  }

  Future<void> _saveTabs() async {
    final prefs = await SharedPreferences.getInstance();
    final tabsJson = jsonEncode(state.map((tab) => tab.toJson()).toList());
    await prefs.setString('tabs', tabsJson);
  }

  Future<void> addTab({required String title}) async {
    final newTab = TabTodo(id: generateNonce(), title: title);
    state = [...state, newTab];
    _saveTabs();
  }

// tabの削除
  Future<void> delete({required String tabId}) async {
    state = state.where((tab) => tab.id != tabId).toList();

    ref.read(todoNotifierProvider.notifier).delete(tabId);
    _saveTabs();
  }

  Future<void> reorder({required int oldIndex, required int newIndex}) async {
    final item = state.removeAt(oldIndex);
    state.insert(newIndex, item);
    _saveTabs();
  }
}

//flutter pub run build_runner build --delete-conflicting-outputs
