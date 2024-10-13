import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/tab_notifier.dart';

class AddTabDialog extends StatefulWidget {
  const AddTabDialog({super.key});

  @override
  State<AddTabDialog> createState() => _AddTabDialogState();
}

class _AddTabDialogState extends State<AddTabDialog> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新しいタブを追加'),
      content: TextField(
        controller: _titleController,
        decoration: const InputDecoration(hintText: 'タイトルを入力'),
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
                  ref.read(tabNotifierProvider.notifier).addTab(
                        title: _titleController.text,
                      );
                  Navigator.of(context).pop();
                  
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
