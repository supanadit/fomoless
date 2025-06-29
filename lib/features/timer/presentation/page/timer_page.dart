import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:fomoless/features/timer/presentation/widget/information_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/time_display_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/time_mode_widget.dart';
import 'package:go_router/go_router.dart';

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
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<TimerBloc>().add(TimerStarted());
                                },
                                child: Text(
                                  timerState.isRunning ? "Stop" : "Start",
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                              const SizedBox(height: 50),
                              const InformationWidget(),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => context.go('/tasks'),
                                child: const Text(
                                  "Go To Tasks",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
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
