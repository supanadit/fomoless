import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Custom animation duration for smoother transitions
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            // Drawer header with gradient
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Fomoless Timer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Menu items with smooth hover effects
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(
                    icon: Icons.timer,
                    title: 'Timer',
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'Settings');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.history,
                    title: 'Timer History',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'Timer History');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.volume_up,
                    title: 'Sound Settings',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'Sound Settings');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.palette,
                    title: 'Theme',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'Theme Settings');
                    },
                  ),
                  const Divider(height: 1),
                  _buildMenuItem(
                    icon: Icons.info,
                    title: 'About',
                    onTap: () {
                      Navigator.pop(context);
                      _showAbout(context);
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.help,
                    title: 'Help',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'Help');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      // Add ripple effect for better visual feedback
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feature),
        content: const Text('This feature is coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('About Fomoless Timer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('A simple and elegant timer app to help you stay focused.'),
            SizedBox(height: 16),
            Text('Features:'),
            Text('• Pomodoro timer'),
            Text('• Stopwatch'),
            Text('• Keyboard shortcuts'),
            Text('• Clean, distraction-free interface'),
            Text('• Smooth sidebar navigation'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}