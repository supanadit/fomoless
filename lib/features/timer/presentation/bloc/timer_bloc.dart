import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  TimerMode _currentMode;

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
        _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
          if (_currentMode == TimerMode.stopwatch) {
            add(
              TimerTicked(
                hours: state.hours,
                minutes: state.minutes,
                seconds: state.seconds,
                milliseconds: state.milliseconds + 10,
              ),
            );
          } else {
            // Pomodoro: count down
            int totalMs =
                state.hours * 3600000 +
                state.minutes * 60000 +
                state.seconds * 1000 +
                state.milliseconds -
                10;
            if (totalMs <= 0) {
              _timer?.cancel();
              emit(
                state.copyWith(
                  isRunning: false,
                  milliseconds: 0,
                  seconds: 0,
                  minutes: 0,
                  hours: 0,
                ),
              );
              return;
            }
            int h = totalMs ~/ 3600000;
            int m = (totalMs % 3600000) ~/ 60000;
            int s = (totalMs % 60000) ~/ 1000;
            int ms = totalMs % 1000;
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
      int ms = event.milliseconds;
      int s = event.seconds;
      int m = event.minutes;
      int h = event.hours;
      if (_currentMode == TimerMode.stopwatch) {
        if (ms >= 1000) {
          ms = 0;
          s++;
        }
        if (s >= 60) {
          s = 0;
          m++;
        }
        if (m >= 60) {
          m = 0;
          h++;
        }
        emit(
          state.copyWith(hours: h, minutes: m, seconds: s, milliseconds: ms),
        );
      } else {
        // Pomodoro: just emit the new state (already decremented)
        emit(
          state.copyWith(hours: h, minutes: m, seconds: s, milliseconds: ms),
        );
      }
    });

    on<TimerToggleMilliseconds>((event, emit) {
      emit(state.copyWith(hideMilliseconds: !state.hideMilliseconds));
    });

    on<TimerModeChanged>((event, emit) {
      _currentMode = event.mode;
      _timer?.cancel();
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
