import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/responsive.dart';
import 'package:todoapp/widget/add_task_dialog.dart';

class BaseView extends StatefulWidget {
  const BaseView({
    super.key,
    required this.selectedIndex,
    required this.child,
  });
  final Widget child;
  final int selectedIndex;

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  void _onDestinationSelected(int index) {
    setState(() {
      switch (index) {
        case 0:
          context.go('/');
        case 1:
          context.go('/timer');

        case 2:
          context.go('/settings');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          if (deviceWidth >= Responsive.md.width) ...[
            NavigationRail(
              indicatorColor: Colors.blueAccent,
              extended: deviceWidth >= Responsive.xl.width,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text(
                    'ホーム',
                    style: TextStyle(fontSize: 24),
                  ),
                  selectedIcon: Icon(Icons.house_outlined, color: Colors.white),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.timer_outlined),
                  label: Text('タイマー'),
                  selectedIcon: Icon(Icons.timer_outlined, color: Colors.white),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('設定'),
                  selectedIcon: Icon(Icons.settings, color: Colors.white),
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
          ],
          Expanded(child: widget.child)
        ],
      ),
      bottomNavigationBar: deviceWidth < Responsive.md.width
          ? NavigationBar(
              // backgroundColor: Colors.blueAccent,
              indicatorColor: Colors.blueAccent,
              onDestinationSelected: _onDestinationSelected,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: widget.selectedIndex,
              
              destinations: const [
                   NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'ホーム',
                  selectedIcon: Icon(Icons.house_outlined, color: Colors.white),
                ),
                NavigationDestination(
                  icon: Icon(Icons.timer_outlined),
                  label: 'タイマー',
                  selectedIcon: Icon(Icons.timer_outlined, color: Colors.white),
                ),
             
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: '設定',
                  selectedIcon: Icon(Icons.settings, color: Colors.white),
                ),
              ],
            )
          : null,
      floatingActionButton:
          deviceWidth < Responsive.md.width && widget.selectedIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AddTaskDialog();
                      },
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : null,
    );
  }
}
