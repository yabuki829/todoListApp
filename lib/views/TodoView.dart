import 'package:flutter/material.dart';
import 'package:todoapp/components/TodoItemWidget.dart';
import 'package:todoapp/notifier/todolist_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todoview extends StatefulWidget {
  const Todoview({super.key, required this.title});
  final String title;
  @override
  State<Todoview> createState() => _TodoviewState();
}

class _TodoviewState extends State<Todoview> {
  String myGoal = "一流のプログラマになる";
  final todoList = todoListNotifierProvider;

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
      body: Consumer(builder: (context, ref, child) {
        final todoList = ref.watch(todoListNotifierProvider);
        return todoList.isEmpty
            ? const SizedBox.shrink()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: todoList.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: TodoItemWidget(todo: todoList[index]),
                    onTap: () {
                      final todo = todoList[index];
                      ref
                          .read(todoListNotifierProvider.notifier)
                          .updateTodo(todo.copyWith(isDone: !todo.isDone));
                    },
                  );
                }),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
