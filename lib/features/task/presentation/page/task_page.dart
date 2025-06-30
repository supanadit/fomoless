import 'package:flutter/material.dart';
import 'package:fomoless/features/task/presentation/widget/task_item_widget.dart';
import 'package:go_router/go_router.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 5,
            children: [
              TaskItemWidget(taskName: "Task 1", taskDuration: "25 minutes"),
              TaskItemWidget(taskName: "Task 2", taskDuration: "15 minutes"),
              TaskItemWidget(taskName: "Task 3", taskDuration: "30 minutes"),
              TaskItemWidget(taskName: "Task 4", taskDuration: "10 minutes"),
              TaskItemWidget(taskName: "Task 5", taskDuration: "20 minutes"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
