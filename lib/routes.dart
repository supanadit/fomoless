import 'package:flutter/material.dart';
import 'package:fomoless/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:fomoless/features/setting/presentation/page/setting_page.dart';
import 'package:fomoless/features/task/presentation/page/task_form_page.dart';
import 'package:fomoless/features/task/presentation/page/task_page.dart';
import 'package:fomoless/features/timer/presentation/page/timer_page.dart';
import 'package:fomoless/sidebar.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNK = GlobalKey<NavigatorState>();

final GoRouter routes = GoRouter(
  initialLocation: '/timer',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _rootNK,
      builder: (context, state, child) {
        return SidebarShell(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/timer',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: TimerPage());
          },
        ),
        GoRoute(
          path: '/dashboard',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: DashboardPage());
          },
        ),
        GoRoute(
          path: '/tasks',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: TaskPage());
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'form',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: TaskFormPage());
              },
            ),
          ],
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: SettingPage());
          },
        ),
      ],
    ),
  ],
);
