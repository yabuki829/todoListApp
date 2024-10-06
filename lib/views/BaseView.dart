import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/responsive.dart';

class BaseView extends StatefulWidget {
  const BaseView({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _selectedIndex = 0;
  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          context.go('/');
        case 1:
          context.go('/timer');
        case 2:
          context.go('/news');
        case 3:
          context.go('/settings');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          if (deviceWidth >= Responsive.md.width) ...[
            NavigationRail(
              backgroundColor: Colors.black12,
              indicatorColor: Colors.white,
              extended: deviceWidth >= Responsive.xl.width,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text(
                    'ホーム',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.timer_outlined),
                  label: Text('タイマー'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.newspaper),
                  label: Text('ニュース'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('設定'),
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
          ],
          Expanded(child: widget.child)
        ],
      ),
      bottomNavigationBar: deviceWidth < Responsive.md.width
          ? NavigationBar(
              onDestinationSelected: _onDestinationSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'ホーム',
                ),
                NavigationDestination(
                  icon: Icon(Icons.timer_outlined),
                  label: 'タイマー',
                ),
                NavigationDestination(
                  icon: Icon(Icons.newspaper),
                  label: 'ニュース',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: '設定',
                ),
              ],
            )
          : null,
    );
  }
}
