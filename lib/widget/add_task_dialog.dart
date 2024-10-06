import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final dateController = TextEditingController();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('タスクを追加'),
            actions: [TextButton(onPressed: () {}, child: const Text("追加"))],
          ),
          body: Consumer(
            builder: (context, ref, _) {
              return Column(
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'タイトルを入力',
                    ),
                  ),
                  TextField(
                    controller: dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      hintText: '締め切りを入力',
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ));
  }
}
