import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/animation/noamimation.dart';
import 'package:todoapp/BaseView.dart';
import 'package:todoapp/views/Settings.dart';
import 'package:todoapp/views/TodoView.dart';
import 'package:todoapp/views/timer_view.dart';

// 参考:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/shell_route.dart

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BaseView(
          selectedIndex: switch (state.uri.path) {
            var path when path.startsWith('/timer') => 1,
            var path when path.startsWith('/settings') => 2,
            var path when path.startsWith('/') => 0,
            _ => 0,
          },
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'initial',
          pageBuilder: (context, state) => buildTransitionPage(
            child: const Todoview(title: "目標を達成するためのTODO"),
          ),
        ),
        GoRoute(
          path: "/timer",
          name: "timer",
          pageBuilder: (context, state) => buildTransitionPage(
            child: const TimerView(),
          ),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) =>
              buildTransitionPage(child: const SettingsView()),
        ),
      ],
    )
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      appBar: AppBar(title: null),
      body: const Center(
        child: Text("404"),
      ),
    ),
  ),
);
