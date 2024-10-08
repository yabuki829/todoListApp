import 'package:flutter/material.dart';
import 'package:todoapp/models/todo/todo.dart';
import 'package:todoapp/views/detail_todo_view.dart';
import 'package:todoapp/widget/TodoItemWidget.dart';
import 'package:todoapp/notifier/todolist_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/widget/add_task_dialog.dart';

class Todoview extends StatefulWidget {
  const Todoview({super.key, required this.title});
  final String title;
  @override
  State<Todoview> createState() => _TodoviewState();
}

class _TodoviewState extends State<Todoview> {
  String myGoal = "一流のプログラマになる";
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDetailTodoView(Todo todo) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: DetailTodoView(todoId: todo.id.toString()),
        );
      },
    );
  }

  void _openAddTodoView() {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return const FractionallySizedBox(
          heightFactor: 0.8,
          child: AddTaskView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              myGoal,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final todoList = ref.watch(todoListNotifierProvider);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "新しいタスクを入力",
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            ref.read(todoListNotifierProvider.notifier).addTodo(
                                title: value, deadline: DateTime.now());
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: todoList.isEmpty
                    ? const Center(child: Text('タスクがありません'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: todoList.length,
                        itemBuilder: ((context, index) {
                          return Dismissible(
                            key: Key(todoList[index].id.toString()),
                            onDismissed: (direction) {
                              ref
                                  .read(todoListNotifierProvider.notifier)
                                  .deleteTodo(id: todoList[index].id);
                            },
                            background: Container(color: Colors.red),
                            child: ListTile(
                              title: TodoItemWidget(todo: todoList[index]),
                              onTap: () {
                                if (index < todoList.length) {
                                  _openDetailTodoView(todoList[index]);
                                }
                              },
                            ),
                          );
                        }),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openAddTodoView();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
