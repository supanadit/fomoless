import 'package:flutter/material.dart';
import 'package:fomoless/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:fomoless/features/task/presentation/page/task_page.dart';
import 'package:fomoless/features/timer/presentation/page/timer_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const TimerPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const DashboardPage();
          },
        ),
        GoRoute(
          path: 'tasks',
          builder: (BuildContext context, GoRouterState state) {
            return const TaskPage();
          },
        ),
      ],
    ),
  ],
);
