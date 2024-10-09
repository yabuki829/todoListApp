import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/notifier/todolist_notifier.dart'; // DateFormatのためにインポート

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _titleController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    // 日付選択した後に時間を選択する
    // TODO:別の方法わかったら修正する

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _dateTimeController.text =
              DateFormat('yyyy年MM月dd日 HH:mm').format(_selectedDateTime!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(
        builder: (context, ref, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'タイトルを入力',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _dateTimeController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: '締め切りを選択',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDateTime(context),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(todoListNotifierProvider.notifier)
                      .addTodo(
                        title: _titleController.text,
                        deadline: _selectedDateTime!,
                      )
                      .then(
                    (value) {
                      const snackBar = SnackBar(
                        content: Text("タスクを追加しました"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.of(context).pop();
                    },
                  );
                },
                child: const Text('追加'),
              ),
            ],
          );
        },
      ),
    );
  }
}
