import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'timer_event.dart';
part 'timer_state.dart';

// Throttle event transformer to prevent excessive UI updates
EventTransformer<E> throttle<E>(Duration duration) {
  return (events, mapper) {
    return events.throttle(duration).switchMap(mapper);
  };
}

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
    // Use restartable for user-initiated events that should cancel previous operations
    on<TimerStarted>(_onTimerStarted, transformer: restartable());
    on<TimerStopped>(_onTimerStopped, transformer: droppable());
    on<TimerReset>(_onTimerReset, transformer: droppable());

    // Use throttle to prevent excessive UI updates on slow devices
    on<TimerTicked>(
      _onTimerTicked,
      transformer: throttle(const Duration(milliseconds: 15)),
    );

    // Use droppable for these less time-sensitive events to prevent queuing
    on<TimerToggleMilliseconds>(
      _onToggleMilliseconds,
      transformer: droppable(),
    );
    on<TimerModeChanged>(_onModeChanged, transformer: droppable());
    on<TimerShortBreakRequested>(
      _onShortBreakRequested,
      transformer: droppable(),
    );
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    if (state.isRunning) {
      _timer?.cancel();
      emit(state.copyWith(isRunning: false));
    } else {
      emit(state.copyWith(isRunning: true));

      // Use mode to determine count direction
      final isCountDown = _currentMode == TimerMode.pomodoro;

      if (!isCountDown) {
        // Stopwatch: continue from current count up value
        _countUpMilliseconds =
            state.hours * 3600000 +
            state.minutes * 60000 +
            state.seconds * 1000 +
            state.milliseconds;
      }

      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
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
            // Reset to initial state based on current mode instead of zero
            if (_currentMode == TimerMode.pomodoro) {
              final initialState = TimerState.initialPomodoro();
              add(
                TimerTicked(
                  hours: initialState.hours,
                  minutes: initialState.minutes,
                  seconds: initialState.seconds,
                  milliseconds: initialState.milliseconds,
                ),
              );
            } else {
              add(
                TimerTicked(hours: 0, minutes: 0, seconds: 0, milliseconds: 0),
              );
            }
            add(TimerStopped());
            return;
          }
          int h = totalMs ~/ 3600000;
          int m = (totalMs % 3600000) ~/ 60000;
          int s = (totalMs % 60000) ~/ 1000;
          int ms = totalMs % 1000;
          add(TimerTicked(hours: h, minutes: m, seconds: s, milliseconds: ms));
        } else {
          // Count up
          _countUpMilliseconds += 10;
          int ms = _countUpMilliseconds % 1000;
          int s = (_countUpMilliseconds ~/ 1000) % 60;
          int m = (_countUpMilliseconds ~/ 60000) % 60;
          int h = _countUpMilliseconds ~/ 3600000;
          add(TimerTicked(hours: h, minutes: m, seconds: s, milliseconds: ms));
        }
      });
    }
  }

  void _onTimerStopped(TimerStopped event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
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
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      state.copyWith(
        hours: event.hours,
        minutes: event.minutes,
        seconds: event.seconds,
        milliseconds: event.milliseconds,
      ),
    );
  }

  void _onToggleMilliseconds(
    TimerToggleMilliseconds event,
    Emitter<TimerState> emit,
  ) {
    emit(state.copyWith(hideMilliseconds: !state.hideMilliseconds));
  }

  void _onModeChanged(TimerModeChanged event, Emitter<TimerState> emit) {
    _currentMode = event.mode;
    _timer?.cancel();
    _countUpMilliseconds = 0;
    if (_currentMode == TimerMode.pomodoro) {
      emit(
        TimerState.initialPomodoro().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
    } else if (_currentMode == TimerMode.stopwatch) {
      emit(
        TimerState.initialStopwatch().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
    } else {
      emit(
        TimerState.initialShortBreak().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
    }
  }

  void _onShortBreakRequested(
    TimerShortBreakRequested event,
    Emitter<TimerState> emit,
  ) {
    _timer?.cancel();
    _countUpMilliseconds = 0;
    if (state.phase == TimerPhase.shortBreak) {
      emit(
        TimerState.initialPomodoro().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
    } else {
      emit(
        TimerState.initialShortBreak().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
