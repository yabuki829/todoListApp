import 'package:flutter/material.dart';
import 'package:todoapp/models/todo/todo.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({super.key, required this.todo});
  final Todo todo;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.todo.isDone
            ? const Icon(Icons.check_box_outlined)
            : const Icon(Icons.check_box_outline_blank),
        Text(widget.todo.title),
      ],
    );
  }
}
