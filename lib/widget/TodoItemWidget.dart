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
    return Text(
      widget.todo.title,
      textAlign: TextAlign.left,
      style: widget.todo.isDone
          ? const TextStyle(
              decoration: TextDecoration.lineThrough,
            )
          : null,
    );
  }
}
