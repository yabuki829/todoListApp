import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/models/todo/todo.dart';
import 'package:todoapp/models/user/user.dart';
part 'todolist_notifier.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  @override
  List<Todo> build() {
    return [
      const Todo(
          id: 1,
          title: "Todoアプリを完成させる",
          isDone: false,
          user: User(id: 1, username: "test"),
          isPremium: false),
      const Todo(
          id: 2,
          title: "資格の勉強をする",
          isDone: false,
          user: User(id: 1, username: "test"),
          isPremium: false)
    ];
  }

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void updateTodo(Todo todo) {
    state = state.map((t) => t.id == todo.id ? todo : t).toList();
  }

  void deleteTodo(Todo todo) {
    state = state.where((t) => t.id != todo.id).toList();
  }
}
