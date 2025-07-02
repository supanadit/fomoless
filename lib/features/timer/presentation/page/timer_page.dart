import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:fomoless/features/timer/presentation/widget/information_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/phase_info_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/shortcut_info_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/time_display_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/time_mode_widget.dart';
import 'package:fomoless/features/timer/presentation/widget/timer_action_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKey(
    BuildContext context,
    KeyEvent event,
    ModeState modeState,
    TimerState timerState,
  ) {
    bool isSpaceKey = event.logicalKey == LogicalKeyboardKey.space;
    bool isEnterKey = event.logicalKey == LogicalKeyboardKey.enter;

    if (event is KeyDownEvent && isSpaceKey) {
      // Toggle start/stop
      if (timerState.isRunning) {
        context.read<TimerBloc>().add(TimerStopped());
      } else {
        context.read<TimerBloc>().add(TimerStarted());
      }
    }

    if (event is KeyDownEvent && isEnterKey) {
      // Only in pomodoro mode, go to next phase
      if (modeState.mode == TimerMode.pomodoro) {
        context.read<TimerBloc>().add(TimerShortBreakRequested());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeBloc, ModeState>(
      builder: (context, modeState) {
        return BlocBuilder<TimerBloc, TimerState>(
          builder: (context, timerState) {
            return KeyboardListener(
              focusNode: _focusNode,
              autofocus: true,
              onKeyEvent: (event) {
                _handleKey(context, event, modeState, timerState);
              },
              child: Scaffold(
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
                      PhaseInfoWidget(timerState: timerState),
                      if (timerState.phase != TimerPhase.stopwatch)
                        const SizedBox(height: 20),
                      TimerActionWidget(
                        timerState: timerState,
                        modeState: modeState,
                      ),
                      const SizedBox(height: 50),
                      const InformationWidget(),
                      const SizedBox(height: 20),
                      const ShortcutInfoWidget(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // Bottom Navigation Bar ( Dashboard and Tasks )
              ),
            );
          },
        );
      },
    );
  }
}
