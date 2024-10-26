import 'package:flutter/material.dart';
import 'package:todoapp/models/tab/tab_todo.dart';
import 'package:todoapp/notifier/select_tab_provider.dart';
import 'package:todoapp/notifier/tab_notifier.dart';
import 'package:todoapp/notifier/todo_notifier.dart';
import 'package:todoapp/responsive.dart';
import 'package:todoapp/views/detail_todo_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/widget/TodoItemWidget.dart';
import 'package:todoapp/widget/add_tab_dialog.dart';
import 'package:todoapp/widget/tab_item.dart';

class Todoview extends ConsumerStatefulWidget {
  const Todoview({super.key, required this.title});
  final String title;

  @override
  ConsumerState<Todoview> createState() => _TodoviewState();
}

class _TodoviewState extends ConsumerState<Todoview> {
  String myGoal = "一流のプログラマになる";
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDetailTodoView({required String todoId}) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: DetailTodoView(
            todoId: todoId,
          ),
        );
      },
    );
  }

  void _openAddTabView() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddTabDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String myGoal = "一流のプログラマになる";
    final selectedIndex = ref.watch(selectTabProvider);
    final tabs = ref.watch(tabNotifierProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
    final todoList = ref
        .watch(todoNotifierProvider)
        .where((todo) => todo.tabId == tabs[selectedIndex].id)
        .toList();

    return DefaultTabController(
      // initialIndex: 0,
      length: tabs.length,

      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    myGoal,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (tabs.length > 1) {
                      ref
                          .read(tabNotifierProvider.notifier)
                          .delete(tabId: tabs[selectedIndex].id);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("タブが0個になってしまいます。"),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
              bottom: tabs.isNotEmpty
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: TabBar(
                                tabAlignment: TabAlignment.start,
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                indicator: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelColor: Colors.white,
                                tabs: tabs.map((TabTodo tab) {
                                  return TabItem(
                                    title: tab.title,
                                    count: ref
                                        .watch(todoNotifierProvider.notifier)
                                        .get(tab.id)
                                        .length,
                                  );
                                }).toList(),
                                onTap: (index) {
                                  ref
                                      .read(selectTabProvider.notifier)
                                      .selectTab(index);
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _openAddTabView();
                              },
                              icon: const Icon(
                                Icons.add_circle_outlined,
                                size: 40,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            )
          ];
        },
        body: todoList.isEmpty
            ? const Center(child: Text("タスクがありません"))
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: deviceWidth >= Responsive.md.width
                        ? const EdgeInsets.all(16.0)
                        : const EdgeInsets.all(4.0),
                    elevation: 4,
                    child: ListTile(
                      title: TodoItemWidget(todo: todoList[index]),
                      onTap: () {
                        _openDetailTodoView(todoId: todoList[index].id);
                      },
                      trailing: IconButton(
                          onPressed: () {
                            ref
                                .read(todoNotifierProvider.notifier)
                                .delete(todoList[index].id);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                },
                itemCount: todoList.length,
              ),
      ),
    );
  }
}
