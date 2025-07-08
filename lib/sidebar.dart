import 'package:flutter/material.dart';

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
                    SizedBox(height: 15),
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
                  ],
                ),
              ),
            ),
          ),
          // Main Content Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
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
