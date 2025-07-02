import 'package:flutter/material.dart';
import 'package:fomoless/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:fomoless/features/setting/presentation/page/setting_page.dart';
import 'package:fomoless/features/task/presentation/page/task_page.dart';
import 'package:fomoless/features/timer/presentation/page/timer_page.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNK = GlobalKey<NavigatorState>();

final GoRouter routes = GoRouter(
  initialLocation: '/timer',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _rootNK,
      builder: (context, state, child) {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sidebar Menu
              Container(
                width: 200,
                decoration: BoxDecoration(color: Colors.blue),
                child: SingleChildScrollView(
                  child: Column(children: [Text("Hello World")]),
                ),
              ),
              // Main Content Area
              Expanded(child: Stack(children: [Text("Hello World"), child])),
            ],
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/timer',
          builder: (BuildContext context, GoRouterState state) {
            return const TimerPage();
          },
        ),
        GoRoute(
          path: '/dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const DashboardPage();
          },
        ),
        GoRoute(
          path: '/tasks',
          builder: (BuildContext context, GoRouterState state) {
            return const TaskPage();
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingPage();
          },
        ),
      ],
    ),
  ],
);
