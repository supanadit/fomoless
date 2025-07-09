import 'package:flutter/material.dart';
import 'package:fomoless/features/task/presentation/widget/task_item_widget.dart';
import 'package:go_router/go_router.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 45,
          bottom: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 5,
            children: [
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Today's Tasks",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(
                      "26 Jun.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TaskItemWidget(
                taskName: "Task 1",
                taskDuration: "25 minutes",
                checked: true,
              ),
              TaskItemWidget(taskName: "Task 2", taskDuration: "15 minutes"),
              TaskItemWidget(taskName: "Task 3", taskDuration: "30 minutes"),
              TaskItemWidget(taskName: "Task 4", taskDuration: "10 minutes"),
              TaskItemWidget(taskName: "Task 5", taskDuration: "20 minutes"),
              // Other than today's tasks
              SizedBox(height: 20),
              Text(
                "Backlog Tasks",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TaskItemWidget(taskName: "Task 6", taskDuration: "45 minutes"),
              TaskItemWidget(taskName: "Task 7", taskDuration: "1 hour"),
              TaskItemWidget(taskName: "Task 8", taskDuration: "30 minutes"),
              TaskItemWidget(taskName: "Task 9", taskDuration: "15 minutes"),
              TaskItemWidget(taskName: "Task 10", taskDuration: "20 minutes"),
              TaskItemWidget(taskName: "Task 11", taskDuration: "50 minutes"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/tasks/form');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
