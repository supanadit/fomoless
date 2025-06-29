import 'package:flutter/material.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';

class PhaseInfoWidget extends StatelessWidget {
  final TimerState timerState;
  const PhaseInfoWidget({super.key, required this.timerState});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: timerState.phase != TimerPhase.stopwatch,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Current Phase:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(
            "${timerState.phase.name[0].toUpperCase()}${timerState.phase.name.substring(1)}",
          ),
        ],
      ),
    );
  }
}
