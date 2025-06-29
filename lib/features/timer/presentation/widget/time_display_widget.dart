import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:fomoless/features/timer/presentation/widget/time_unit_widget.dart';

class TimeDisplayWidget extends StatelessWidget {
  const TimeDisplayWidget({super.key});

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeBloc, ModeState>(
      builder: (context, modeState) {
        return BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            // You can use modeState.mode here to customize display if needed
            return InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onDoubleTap: () {
                context.read<TimerBloc>().add(TimerReset());
              },
              onTap: () {
                context.read<TimerBloc>().add(TimerToggleMilliseconds());
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TimeUnitWidget(value: twoDigits(state.hours)),
                    const Text(":", style: TextStyle(fontSize: 60.0)),
                    TimeUnitWidget(value: twoDigits(state.minutes)),
                    const Text(":", style: TextStyle(fontSize: 60.0)),
                    TimeUnitWidget(value: twoDigits(state.seconds)),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Visibility(
                        visible: !state.hideMilliseconds,
                        child: Row(
                          children: [
                            const Text(
                              ".",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              state.milliseconds.toString().padLeft(3, '0'),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
