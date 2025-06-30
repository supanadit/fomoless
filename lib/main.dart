import 'package:flutter/material.dart';
import 'package:fomoless/features/task/presentation/page/task_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fomoless/di.dart';
import 'package:fomoless/features/timer/presentation/page/timer_page.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();

  await sl<FlutterLocalNotificationsPlugin>().initialize(
    sl<InitializationSettings>(),
  );
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const TimerPage();
      },
      routes: <RouteBase>[
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
