import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:fomoless/features/timer/presentation/widget/information_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/time_display_widget.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TimerBloc()),
        BlocProvider(create: (_) => ModeBloc()),
      ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<ModeBloc>().add(
                                  ModeSwitchRequested(TimerMode.pomodoro),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    modeState.mode == TimerMode.pomodoro
                                    ? Colors.grey.withAlpha(180)
                                    : Colors.transparent,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Pomodoro",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ModeBloc>().add(
                                  ModeSwitchRequested(TimerMode.stopwatch),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    modeState.mode == TimerMode.stopwatch
                                    ? Colors.grey.withAlpha(180)
                                    : Colors.transparent,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Stopwatch",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const TimeDisplayWidget(),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            context.read<TimerBloc>().add(TimerStarted());
                          },
                          child: Text(
                            timerState.isRunning ? "Stop Timer" : "Start Timer",
                            style: const TextStyle(fontSize: 20.0),
                          ),
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
  }
}
