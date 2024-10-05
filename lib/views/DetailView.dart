import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/models/todo/todo.dart';

class Detailview extends StatefulWidget {
  const Detailview({
    super.key,
    required this.todo,
  });
  final Todo todo;
  @override
  State<Detailview> createState() => _DetailviewState();
}

class _DetailviewState extends State<Detailview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null),
      body: Consumer(
        builder: (context, ref, _) {
          return Center(
            child: Column(
              children: [
                Text(
                  widget.todo.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "タスクID: ${widget.todo.id}",
                ),
                const SizedBox(height: 10),
                Text(
                  "完了状態: ${widget.todo.isDone ? '完了' : '未完了'}",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
