import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';

class TimerActionWidget extends StatelessWidget {
  final TimerState timerState;
  final ModeState modeState;

  const TimerActionWidget({
    super.key,
    required this.timerState,
    required this.modeState,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<TimerBloc>().add(TimerStarted());
          },
          child: Text(
            timerState.isRunning ? "Stop" : "Start",
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
        if (modeState.mode == TimerMode.pomodoro) ...[
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              context.read<TimerBloc>().add(TimerShortBreakRequested());
            },
            child: Text(
              timerState.isRunning
                  ? "Done"
                  : (timerState.phase == TimerPhase.shortBreak
                        ? "Skip Break"
                        : "Break Phase"),
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ],
    );
  }
}
