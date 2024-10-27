import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/comment_provider.dart';
import 'package:todoapp/notifier/todo_notifier.dart';
import 'package:todoapp/utils/date_format.dart';

class DetailTodoView extends ConsumerStatefulWidget {
  const DetailTodoView({super.key, required this.todoId});

  final String todoId;
  @override
  ConsumerState<DetailTodoView> createState() => _DetailTodoViewState();
}

class _DetailTodoViewState extends ConsumerState<DetailTodoView> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todo =
        ref.watch(todoNotifierProvider.notifier).getById(widget.todoId);
    final comments = ref
        .watch(commentNotifierProvider)
        .where((comment) => comment.todoId == todo.id)
        .toList();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            todo.title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(todoNotifierProvider.notifier).delete(todo.id);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(DateFormater.formatHowManyDays(todo.deadline)),
                Text(DateFormater.format(todo.deadline)),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          // hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "新しいコメントを入力",
                ),
                onSubmitted: (value) {
                  print("コメントを追加します。");
                  ref
                      .read(commentNotifierProvider.notifier)
                      .add(value, todo.id);
                  _controller.clear();
                },
              ),
            ),
          ),
        ),
        SliverList.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              selectedColor: Colors.grey,
              title: Text(comments[index].text),
              trailing: IconButton(
                onPressed: () {
                  ref.read(commentNotifierProvider.notifier).deleteComment(
                      todoId: todo.id, commentId: comments[index].id);
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
          itemCount: comments.length,
        ),
      ],
    );
  }
}

// 参考
// https://github.com/otabekinha/flutter_modal_bottom_sheet/blob/main/lib/info_screen.dart

// flutter run -d chrome --web-renderer html
