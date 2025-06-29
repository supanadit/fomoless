import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const fontSizeTime = 60.0;

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  bool isRunning = false;
  Timer? _timer;

  void startTimer() {
    if (isRunning) {
      _timer?.cancel();
      setState(() {
        isRunning = false;
      });
    } else {
      setState(() {
        isRunning = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          seconds++;
          if (seconds >= 60) {
            seconds = 0;
            minutes++;
          }
          if (minutes >= 60) {
            minutes = 0;
            hours++;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  twoDigits(hours),
                  style: const TextStyle(fontSize: fontSizeTime),
                ),
                const Text(":", style: TextStyle(fontSize: fontSizeTime)),
                Text(
                  twoDigits(minutes),
                  style: const TextStyle(fontSize: fontSizeTime),
                ),
                const Text(":", style: TextStyle(fontSize: fontSizeTime)),
                Text(
                  twoDigits(seconds),
                  style: const TextStyle(fontSize: fontSizeTime),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startTimer,
              child: Text(
                isRunning ? "Stop Timer" : "Start Timer",
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
