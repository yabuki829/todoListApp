import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/exceptions/exception.dart';
import 'package:todoapp/models/todo/todo.dart';

part 'todo_notifier.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  Future<List<Todo>> build() async {
    return [];
  }

  Future<void> create(String title) async {
    throw APIException.notFound();
  }

  Future<void> delete(String id) async {}
}
