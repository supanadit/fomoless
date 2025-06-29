import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  TimerMode _currentMode;
  int _countUpMilliseconds = 0; // Track count up milliseconds separately

  TimerBloc(TimerMode initialMode)
    : _currentMode = initialMode,
      super(
        initialMode == TimerMode.pomodoro
            ? TimerState.initialPomodoro()
            : TimerState.initialStopwatch(),
      ) {
    on<TimerStarted>((event, emit) {
      if (state.isRunning) {
        _timer?.cancel();
        emit(state.copyWith(isRunning: false));
      } else {
        emit(state.copyWith(isRunning: true));

        // Reset the count up milliseconds for a fresh start if we're counting up
        final isInitiallyCountDown =
            state.hours > 0 ||
            state.minutes > 0 ||
            state.seconds > 0 ||
            state.milliseconds > 0;

        if (!isInitiallyCountDown) {
          _countUpMilliseconds = 0;
        } else {
          // For count down, initialize based on current state
          _countUpMilliseconds =
              state.hours * 3600000 +
              state.minutes * 60000 +
              state.seconds * 1000 +
              state.milliseconds;
        }

        _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
          final isCountDown = isInitiallyCountDown;

          if (isCountDown) {
            // Count down
            int totalMs =
                state.hours * 3600000 +
                state.minutes * 60000 +
                state.seconds * 1000 +
                state.milliseconds -
                10;
            if (totalMs <= 0) {
              _timer?.cancel();
              add(
                TimerTicked(hours: 0, minutes: 0, seconds: 0, milliseconds: 0),
              );
              add(TimerStopped());
              return;
            }
            int h = totalMs ~/ 3600000;
            int m = (totalMs % 3600000) ~/ 60000;
            int s = (totalMs % 60000) ~/ 1000;
            int ms = totalMs % 1000;
            add(
              TimerTicked(hours: h, minutes: m, seconds: s, milliseconds: ms),
            );
          } else {
            // Count up
            _countUpMilliseconds += 10;
            int ms = _countUpMilliseconds % 1000;
            int s = (_countUpMilliseconds ~/ 1000) % 60;
            int m = (_countUpMilliseconds ~/ 60000) % 60;
            int h = _countUpMilliseconds ~/ 3600000;
            add(
              TimerTicked(hours: h, minutes: m, seconds: s, milliseconds: ms),
            );
          }
        });
      }
    });

    on<TimerStopped>((event, emit) {
      _timer?.cancel();
      emit(state.copyWith(isRunning: false));
    });

    on<TimerReset>((event, emit) {
      _timer?.cancel();
      _countUpMilliseconds = 0;
      if (_currentMode == TimerMode.pomodoro) {
        emit(
          TimerState.initialPomodoro().copyWith(
            hideMilliseconds: state.hideMilliseconds,
          ),
        );
      } else {
        emit(
          TimerState.initialStopwatch().copyWith(
            hideMilliseconds: state.hideMilliseconds,
          ),
        );
      }
    });

    on<TimerTicked>((event, emit) {
      emit(
        state.copyWith(
          hours: event.hours,
          minutes: event.minutes,
          seconds: event.seconds,
          milliseconds: event.milliseconds,
        ),
      );
    });

    on<TimerToggleMilliseconds>((event, emit) {
      emit(state.copyWith(hideMilliseconds: !state.hideMilliseconds));
    });

    on<TimerModeChanged>((event, emit) {
      _currentMode = event.mode;
      _timer?.cancel();
      _countUpMilliseconds = 0;
      if (_currentMode == TimerMode.pomodoro) {
        emit(
          TimerState.initialPomodoro().copyWith(
            hideMilliseconds: state.hideMilliseconds,
          ),
        );
      } else {
        emit(
          TimerState.initialStopwatch().copyWith(
            hideMilliseconds: state.hideMilliseconds,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
