import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskFormPage extends StatelessWidget {
  const TaskFormPage({super.key});

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
              Text(
                "What do you want to do ?",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Task Name Title
              Text(
                "Task Name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Buy groceries, complete project, etc.",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              // Task Duration Title
              Text(
                "Task Duration",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "E.g. 30m, 1h, 2h30m",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              // Task Description Title
              Text(
                "Task Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Add details about the task",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              // Schedule Task Title
              Text(
                "Schedule Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Select Date Picker
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Pick a date",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  context.go('/tasks');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  "Add Task",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
