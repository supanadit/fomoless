import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:fomoless/features/timer/presentation/widget/information_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/time_display_widget.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TimeDisplayWidget(),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(TimerStarted());
                    },
                    child: Text(
                      state.isRunning ? "Stop Timer" : "Start Timer",
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
      ),
    );
  }
}
