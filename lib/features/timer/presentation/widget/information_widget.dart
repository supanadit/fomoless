import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Information:", style: TextStyle(color: Colors.grey)),
        Text(
          "1. To reset the timer, double tap on the time display.",
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          "2. To toggle milliseconds, tap on the time display.",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
