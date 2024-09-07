import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/animation/noamimation.dart';
import 'package:todoapp/views/BaseView.dart';
import 'package:todoapp/views/DetailView.dart';
import 'package:todoapp/views/NewsView.dart';
import 'package:todoapp/views/Settings.dart';
import 'package:todoapp/views/TodoView.dart';

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
        return BaseView(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'initial',
          pageBuilder: (context, state) => buildTransitionPage(
            child: const Todoview(title: "目標を達成するためのTODO"),
          ),
          routes: [
            GoRoute(
              path: 'id',
              name: 'detail',
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const Detailview(),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) =>
              buildTransitionPage(child: const SettingsView()),
        ),
        GoRoute(
          path: '/news',
          name: 'news',
          pageBuilder: (context, state) =>
              buildTransitionPage(child: const NewsVew()),
        ),
      ],
    )
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
