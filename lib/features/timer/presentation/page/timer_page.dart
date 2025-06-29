import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:fomoless/features/timer/presentation/widget/information_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/time_mode_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/time_display_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/timer_action_widget.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ModeBloc(),
      child: BlocBuilder<ModeBloc, ModeState>(
        builder: (context, modeState) {
          return BlocProvider(
            create: (_) => TimerBloc(modeState.mode),
            child: BlocListener<ModeBloc, ModeState>(
              listener: (context, modeState) {
                context.read<TimerBloc>().add(TimerModeChanged(modeState.mode));
              },
              child: BlocBuilder<ModeBloc, ModeState>(
                builder: (context, modeState) {
                  return BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, timerState) {
                      return Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TimeModeWidget(
                                selectedMode: modeState.mode,
                                onModeSelected: (mode) {
                                  context.read<ModeBloc>().add(
                                    ModeSwitchRequested(mode),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              const TimeDisplayWidget(),
                              if (timerState.phase != TimerPhase.stopwatch)
                                const SizedBox(height: 10),
                              if (timerState.phase == TimerPhase.stopwatch)
                                const SizedBox(height: 30),
                              Visibility(
                                visible:
                                    timerState.phase != TimerPhase.stopwatch,
                                // Capitalize first letter of the phase name
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Current Phase:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "${timerState.phase.name[0].toUpperCase()}${timerState.phase.name.substring(1)}",
                                    ),
                                  ],
                                ),
                              ),
                              if (timerState.phase != TimerPhase.stopwatch)
                                const SizedBox(height: 20),
                              TimerActionWidget(
                                timerState: timerState,
                                modeState: modeState,
                              ),
                              const SizedBox(height: 50),
                              const InformationWidget(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
