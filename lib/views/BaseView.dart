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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          if (deviceWidth >= Responsive.md.width) ...[
            NavigationRail(
              extended: deviceWidth >= Responsive.lg.width,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('ホーム'),
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
              onDestinationSelected: (int index) {
                setState(
                  () {
                    _selectedIndex = index;
                    switch (_selectedIndex) {
                      case 0:
                        context.go('/');
                      case 1:
                        context.go("/news");
                      case 2:
                        context.go("/settings");
                    }
                  },
                );
              },
            ),
          ],
          Expanded(child: widget.child)
        ],
      ),
      bottomNavigationBar: deviceWidth < Responsive.md.width
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue[800],
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                  switch (_selectedIndex) {
                    case 0:
                      context.go('/');
                    case 1:
                      context.go('/news');
                    case 2:
                      context.go('/settings');
                  }
                });
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'ホーム',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: 'ニュース',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '設定',
                ),
              ],
            )
          : null,
    );
  }
}
