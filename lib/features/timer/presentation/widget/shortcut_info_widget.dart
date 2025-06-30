import 'package:flutter/material.dart';

class ShortcutInfoWidget extends StatelessWidget {
  const ShortcutInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Keyboard Shortcut:", style: TextStyle(color: Colors.grey)),
          Text(
            "1. To start/stop the timer, press Space.",
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            "2. In Pomodoro mode, press Enter to go to the next phase.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
