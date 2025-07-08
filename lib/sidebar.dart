import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarShell extends StatefulWidget {
  final Widget child;
  const SidebarShell({super.key, required this.child});

  @override
  State<SidebarShell> createState() => _SidebarShellState();
}

class _SidebarShellState extends State<SidebarShell> {
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
      backgroundColor: Color(0xFFF7F8FA),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sidebar Menu
          Visibility(
            visible: !showInMain,
            child: SizedBox(
              width: 250,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Spacing
                    SizedBox(height: 7),
                    // Sidebar Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Fomoless",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: _onSidebarTap,
                            child: Icon(Icons.slideshow),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Sidebar Menu Items
                    SidebarMenuItem(
                      icon: Icons.timer,
                      title: "Timer",
                      onTap: () {
                        context.go('/timer');
                      },
                    ),
                    SizedBox(height: 10),
                    SidebarMenuItem(
                      icon: Icons.task,
                      title: "Tasks",
                      onTap: () {
                        context.go('/tasks');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Main Content Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
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
          ),
        ],
      ),
    );
  }
}

class SidebarMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool active;

  const SidebarMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFE4E6E8) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
