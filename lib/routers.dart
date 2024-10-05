import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/animation/noamimation.dart';
import 'package:todoapp/models/todo/todo.dart';
import 'package:todoapp/views/BaseView.dart';
import 'package:todoapp/views/DetailView.dart';
import 'package:todoapp/views/LoginView.dart';
import 'package:todoapp/views/NewsView.dart';
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
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
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
              path: 'todo/:id',
              name: 'detail',
              pageBuilder: (context, state) {
                final todo = state.extra as Todo;
                return MaterialPage(
                  key: state.pageKey,
                  child: Detailview(todo: todo),
                );
              },
            ),
          ],
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
      appBar: AppBar(title: null),
      body: const Center(
        child: Text("404"),
      ),
    ),
  ),
);
