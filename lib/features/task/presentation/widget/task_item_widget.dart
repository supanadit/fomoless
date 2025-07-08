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
        // Border Only Bottom
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey[400]!, width: 1.0),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
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
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.timer, size: 14, color: Color(0xFFa0a1a6)),
                    SizedBox(width: 5),
                    Text(
                      taskDuration ?? "No duration specified",
                      style: TextStyle(color: Color(0xFFa0a1a6)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
