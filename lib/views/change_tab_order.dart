import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/tab_notifier.dart';

class ChangeTabOrderView extends StatefulWidget {
  const ChangeTabOrderView({super.key});

  @override
  State<ChangeTabOrderView> createState() => _ChangeTabOrderViewState();
}

class _ChangeTabOrderViewState extends State<ChangeTabOrderView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final tabs = ref.watch(tabNotifierProvider);
      return ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        itemCount: tabs.length,
        itemBuilder: (context, i) {
          return ListTile(
            key: Key('$i'),
            title: Text(tabs[i].title),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            ref.read(tabNotifierProvider.notifier).reorder(
                  oldIndex: oldIndex,
                  newIndex: newIndex,
                );
          });
        },
      );
    });
  }
}
