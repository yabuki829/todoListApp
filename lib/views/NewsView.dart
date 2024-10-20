import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/todo_notifier.dart';

class NewsVew extends StatefulWidget {
  const NewsVew({super.key});

  @override
  State<NewsVew> createState() => _NewsVewState();
}

class _NewsVewState extends State<NewsVew> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('ニュース'),
        ),
        SliverToBoxAdapter(child: Consumer(builder: (context, ref, child) {
          final todos = ref.watch(todoNotifierProvider);
          return todos.when(data: (data) {
            return Text("ok");
          }, error: (error, stack) {
            return SelectableText(error.toString());
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          });
        }))
      ],
    );
  }
}
