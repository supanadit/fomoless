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
        return SidebarHeroShell(child: child);
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

class SidebarHeroShell extends StatefulWidget {
  final Widget child;
  const SidebarHeroShell({super.key, required this.child});

  @override
  State<SidebarHeroShell> createState() => _SidebarHeroShellState();
}

class _SidebarHeroShellState extends State<SidebarHeroShell> {
  bool showInMain = false;

  void _onSidebarTap() {
    setState(() {
      showInMain = true;
    });
  }

  void _onMainTap() {
    setState(() {
      showInMain = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sidebar Menu
          Visibility(
            visible: !showInMain,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fomoless"),
                          InkWell(
                            onTap: _onSidebarTap,
                            child: Icon(Icons.slideshow),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Main Content Area
          Expanded(
            child: Stack(
              children: [
                widget.child,
                if (showInMain)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: _onMainTap,
                      child: Icon(Icons.slideshow),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
