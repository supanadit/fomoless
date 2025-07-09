import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  final String taskName;
  final String? taskDuration;
  final String? taskSchedule;
  final bool checked;

  const TaskItemWidget({
    super.key,
    required this.taskName,
    this.taskDuration,
    this.taskSchedule,
    this.checked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      // decoration: BoxDecoration(
      //   // Border Only Bottom
      //   border: Border(
      //     bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
      //   ),
      // ),
      child: Row(
        children: [
          // Circle Checkbox Placeholder
          checked
              ? Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, size: 16, color: Colors.white),
                )
              : Container(
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
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Color(0xFFa0a1a6),
                    ),
                    SizedBox(width: 5),
                    Text(
                      taskSchedule ?? "No schedule specified",
                      style: TextStyle(color: Color(0xFFa0a1a6)),
                    ),
                    SizedBox(width: 10),
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
