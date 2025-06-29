import 'package:flutter/material.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';

class TimeModeWidget extends StatelessWidget {
  final TimerMode selectedMode;
  final void Function(TimerMode) onModeSelected;

  const TimeModeWidget({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => onModeSelected(TimerMode.pomodoro),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedMode == TimerMode.pomodoro
                ? Colors.grey.withAlpha(180)
                : Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            elevation: 0,
          ),
          child: const Text("Pomodoro", style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => onModeSelected(TimerMode.stopwatch),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedMode == TimerMode.stopwatch
                ? Colors.grey.withAlpha(180)
                : Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            elevation: 0,
          ),
          child: const Text("Stopwatch", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
