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

  Widget _buildModeButton({required String label, required TimerMode mode}) {
    return ElevatedButton(
      onPressed: () => onModeSelected(mode),
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedMode == mode
            ? Colors.grey.withAlpha(180)
            : Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        elevation: 0,
      ),
      child: Text(label, style: const TextStyle(color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildModeButton(label: "Pomodoro", mode: TimerMode.pomodoro),
        const SizedBox(width: 10),
        _buildModeButton(label: "Stopwatch", mode: TimerMode.stopwatch),
      ],
    );
  }
}
