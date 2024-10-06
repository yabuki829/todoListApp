import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/todolist_notifier.dart';
import 'package:todoapp/utils/date_format.dart';

class DetailTodoView extends StatefulWidget {
  const DetailTodoView({super.key, required this.todoId});

  final String todoId;

  @override
  State<DetailTodoView> createState() => _DetailTodoViewState();
}

class _DetailTodoViewState extends State<DetailTodoView> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(
        builder: (context, ref, child) {
          final todoList = ref.watch(todoListNotifierProvider);
          final todo =
              todoList.firstWhere((element) => element.id == widget.todoId);
          return Column(
            children: [
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(todo.deadline.toString()),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "新しいコメントを入力",
                ),
                onSubmitted: (value) {
                  ref
                      .watch(todoListNotifierProvider.notifier)
                      .addComment(todo.id, value);
                  _controller.clear();
                },
              ),
              Expanded(
                child: todo.comments.isEmpty
                    ? const Center(child: Text("コメントがありません。"))
                    : ListView.builder(
                        itemCount: todo.comments.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(todo.comments[index].text),
                            subtitle: Text(DateFormater.format(
                                todo.comments[index].createdAt)),
                            trailing: IconButton(
                              onPressed: () {
                                ref
                                    .watch(todoListNotifierProvider.notifier)
                                    .deleteComment(
                                        todo.id, todo.comments[index].id);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}


// 参考
// https://github.com/otabekinha/flutter_modal_bottom_sheet/blob/main/lib/info_screen.dart