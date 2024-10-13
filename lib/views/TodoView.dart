import 'package:flutter/material.dart';
import 'package:todoapp/models/tab/tab_todo.dart';
import 'package:todoapp/models/todo/todo.dart';
import 'package:todoapp/notifier/tab_notifier.dart';
import 'package:todoapp/responsive.dart';
import 'package:todoapp/views/detail_todo_view.dart';
import 'package:todoapp/widget/TodoItemWidget.dart';
import 'package:todoapp/notifier/todolist_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/widget/add_tab_dialog.dart';
import 'package:todoapp/widget/add_task_dialog.dart';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDetailTodoView(Todo todo) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: DetailTodoView(todoId: todo.id.toString()),
        );
      },
    );
  }

  void _openAddTodoView({required String tabId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskDialog(tabId: tabId);
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
    final double deviceWidth = MediaQuery.of(context).size.width;
    final tabs = ref.watch(tabNotifierProvider);
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
                    final tabId =
                        tabs[DefaultTabController.of(context).index].id;
                    ref.read(tabNotifierProvider.notifier).deleteTab(tabId);
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    _openAddTabView();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: ClipRRect(
                  // borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black54,
                    tabs: tabs.map((TabTodo tab) {
                      return TabItem(title: tab.title, count: tab.todos.length);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ];
        },
        body: tabs.isEmpty
            ? const Center(child: Text("タブがありません"))
            : TabBarView(
                children: tabs.map((tab) {
                  final todoList = tab.todos;
                  return todoList.isEmpty
                      ? const Center(child: Text("タスクがありません"))
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: todoList.length,
                          itemBuilder: (context, todoIndex) {
                            return Card(
                              margin: deviceWidth >= Responsive.md.width
                                  ? const EdgeInsets.all(16.0)
                                  : const EdgeInsets.all(4.0),
                              elevation: 4,
                              child: ListTile(
                                title:
                                    TodoItemWidget(todo: todoList[todoIndex]),
                                onTap: () {
                                  if (todoIndex < todoList.length) {
                                    _openDetailTodoView(todoList[todoIndex]);
                                  }
                                },
                                trailing: IconButton(
                                    onPressed: () {
                                      print(DefaultTabController.of(context)
                                          .index);
                                    },
                                    icon: const Icon(Icons.delete)),
                              ),
                            );
                          },
                        );
                }).toList(),
              ),
      ),
    );
  }
}
