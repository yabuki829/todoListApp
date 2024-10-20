import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/tab_notifier.dart';
import 'package:todoapp/utils/date_format.dart';

class DetailTodoView extends ConsumerStatefulWidget {
  const DetailTodoView({super.key, required this.todoId, required this.tabId});

  final String todoId;
  final String tabId;
  @override
  ConsumerState<DetailTodoView> createState() => _DetailTodoViewState();
}

class _DetailTodoViewState extends ConsumerState<DetailTodoView> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(tabNotifierProvider.notifier).getTodo(
          tabId: widget.tabId,
          todoId: widget.todoId,
        );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  // ref
                  //     .read(todoListNotifierProvider.notifier)
                  //     .addComment(todoId: todo.id, commentText: value);
                  // _controller.clear();
                },
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                selectedColor: Colors.grey,
                title: Text(todo.comments[index].text),
                trailing: IconButton(
                  onPressed: () {
                    print("削除します");
                    // ref.read(todoListNotifierProvider.notifier).deleteComment(
                    //     todoId: todo.id, commentId: todo.comments[index].id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
            childCount: todo.comments.length,
          ),
        ),
      ],
    );
  }
}

// 参考
// https://github.com/otabekinha/flutter_modal_bottom_sheet/blob/main/lib/info_screen.dart

// flutter run -d chrome --web-renderer html
