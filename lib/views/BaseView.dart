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
    return Scaffold(
      body: Row(
        children: [
          if (Responsive.isMobile(context)) ...[
            NavigationRail(
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.newspaper),
                  label: Text('News'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
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
      bottomNavigationBar: Responsive.isDesktop(context)
          ? null
          : BottomNavigationBar(
              items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.newspaper), label: "News"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Setting"),
                ],
              onTap: (index) {
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
              }),
    );
  }
}