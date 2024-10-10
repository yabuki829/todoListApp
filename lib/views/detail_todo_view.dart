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
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref
                      .watch(todoListNotifierProvider.notifier)
                      .deleteTodo(id: widget.todoId);
                  // Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete),
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final todoList = ref.read(todoListNotifierProvider);
          final todo =
              todoList.firstWhere((element) => element.id == widget.todoId);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(DateFormater.formatHowManyDays(todo.deadline)),
                Text(DateFormater.format(todo.deadline)),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "新しいコメントを入力",
                  ),
                  onSubmitted: (value) {
                    ref
                        .watch(todoListNotifierProvider.notifier)
                        .addComment(todoId: todo.id, commentText: value);
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
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("コメントを削除します"),
                                          content: Text("本当に削除しますか？"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  ref
                                                      .watch(
                                                          todoListNotifierProvider
                                                              .notifier)
                                                      .deleteComment(
                                                          todoId: todo.id,
                                                          commentId: todo
                                                              .comments[index]
                                                              .id);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("削除"))
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


// 参考
// https://github.com/otabekinha/flutter_modal_bottom_sheet/blob/main/lib/info_screen.dart