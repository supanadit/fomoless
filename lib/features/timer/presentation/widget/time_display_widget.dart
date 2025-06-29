import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timer_bloc.dart';

class TimeDisplayWidget extends StatelessWidget {
  const TimeDisplayWidget({super.key});

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
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
                Text(
                  twoDigits(state.hours),
                  style: const TextStyle(fontSize: 60.0),
                ),
                const Text(":", style: TextStyle(fontSize: 60.0)),
                Text(
                  twoDigits(state.minutes),
                  style: const TextStyle(fontSize: 60.0),
                ),
                const Text(":", style: TextStyle(fontSize: 60.0)),
                Text(
                  twoDigits(state.seconds),
                  style: const TextStyle(fontSize: 60.0),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Visibility(
                    visible: !state.hideMilliseconds,
                    child: Row(
                      children: [
                        const Text(
                          ".",
                          style: TextStyle(fontSize: 30, color: Colors.grey),
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
  }
}
