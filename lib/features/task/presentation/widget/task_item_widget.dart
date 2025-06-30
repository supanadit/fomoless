import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  final String taskName;
  final String? taskDuration;

  const TaskItemWidget({super.key, required this.taskName, this.taskDuration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            taskDuration ?? "No duration specified",
            style: TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
