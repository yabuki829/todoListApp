import 'package:flutter/material.dart';
import 'package:todoapp/widget/TodoItemWidget.dart';
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
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            ref
                                .read(todoListNotifierProvider.notifier)
                                .addTodo(_controller.text);
                            _controller.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.add_circle_outline_outlined,
                        ))
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
                                  .deleteTodo(todoList[index].id);
                            },
                            background: Container(color: Colors.red),
                            child: ListTile(
                              title: TodoItemWidget(todo: todoList[index]),
                              onTap: () {
                                final todo = todoList[index];
                                ref
                                    .read(todoListNotifierProvider.notifier)
                                    .updateTodo(
                                        todo.copyWith(isDone: !todo.isDone));
                              },
                            ),
                          );
                        }),
                      ),
              ),
            ],
          );
        },
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.add),
      ),
    );
  }
}
