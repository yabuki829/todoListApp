import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/notifier/tab_notifier.dart';
import 'package:todoapp/notifier/todolist_notifier.dart'; // DateFormatのためにインポート

class AddTaskDialog extends StatefulWidget {
  final String tabId;
  const AddTaskDialog({super.key, required this.tabId});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController(
    text: DateFormat('yyyy年MM月dd日 HH:mm').format(DateTime.now()),
  );
  DateTime _selectedDateTime = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  void _showDateTimePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: _selectedDateTime,
            mode: CupertinoDatePickerMode.dateAndTime,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                _selectedDateTime = newDateTime;
                _dateTimeController.text =
                    DateFormat('yyyy年MM月dd日 HH:mm').format(_selectedDateTime);
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新しいタスクを追加'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'タイトルを入力',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: '締め切りを選択',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: _showDateTimePicker,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  ref.read(tabNotifierProvider.notifier).addTodo(
                        tabId: widget.tabId,
                        title: _titleController.text,
                        deadline: _selectedDateTime,
                      );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("タスクを追加しました")),
                  );
                }
              },
              child: const Text('追加'),
            );
          },
        ),
      ],
    );
  }
}
