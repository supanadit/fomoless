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
  DateTime? _startTime; // For accurate timing
  int _initialCountdownMs = 0; // For countdown mode
  Stopwatch? _stopwatch; // For stopwatch mode
  int _pomodoroCount = 0; // Track completed pomodoros

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
    on<TimerLongBreakRequested>(
      _onLongBreakRequested,
      transformer: droppable(),
    );

    on<TimerPhaseCompleted>(_onPhaseCompleted, transformer: droppable());
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    if (state.isRunning) {
      _timer?.cancel();
      _stopwatch?.stop();
      emit(state.copyWith(isRunning: false));
    } else {
      emit(state.copyWith(isRunning: true));
      final isCountDown = _currentMode == TimerMode.pomodoro;
      if (isCountDown) {
        // Countdown: record start time and initial ms
        _startTime = DateTime.now();
        _initialCountdownMs =
            state.hours * 3600000 +
            state.minutes * 60000 +
            state.seconds * 1000 +
            state.milliseconds;
      } else {
        // Stopwatch: start or resume
        _stopwatch ??= Stopwatch();
        if (!_stopwatch!.isRunning) {
          _stopwatch!.start();
        }
        if (_countUpMilliseconds == 0) {
          _countUpMilliseconds =
              state.hours * 3600000 +
              state.minutes * 60000 +
              state.seconds * 1000 +
              state.milliseconds;
        }
      }
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        if (isCountDown) {
          final now = DateTime.now();
          final elapsed = now.difference(_startTime!).inMilliseconds;
          int totalMs = _initialCountdownMs - elapsed;
          if (totalMs <= 0) {
            _timer?.cancel();
            // Transition to the next phase, but do not auto-start
            if (state.phase == TimerPhase.pomodoro) {
              _pomodoroCount++;
              if (_pomodoroCount % 4 == 0) {
                add(TimerLongBreakRequested());
              } else {
                add(TimerShortBreakRequested());
              }
            } else if (state.phase == TimerPhase.shortBreak) {
              add(TimerPhaseCompleted());
            } else if (state.phase == TimerPhase.longBreak) {
              add(TimerPhaseCompleted());
            } else {
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
                  TimerTicked(
                    hours: 0,
                    minutes: 0,
                    seconds: 0,
                    milliseconds: 0,
                  ),
                );
              }
              add(TimerStopped());
            }
            return;
          }
          int h = totalMs ~/ 3600000;
          int m = (totalMs % 3600000) ~/ 60000;
          int s = (totalMs % 60000) ~/ 1000;
          int ms = totalMs % 1000;
          add(TimerTicked(hours: h, minutes: m, seconds: s, milliseconds: ms));
        } else {
          // Stopwatch: use actual elapsed time
          final elapsed =
              _stopwatch!.elapsedMilliseconds + _countUpMilliseconds;
          int ms = elapsed % 1000;
          int s = (elapsed ~/ 1000) % 60;
          int m = (elapsed ~/ 60000) % 60;
          int h = elapsed ~/ 3600000;
          add(TimerTicked(hours: h, minutes: m, seconds: s, milliseconds: ms));
        }
      });
    }
  }

  void _onTimerStopped(TimerStopped event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _stopwatch?.stop();
    emit(state.copyWith(isRunning: false));
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _stopwatch?.reset();
    _countUpMilliseconds = 0;
    _startTime = null;
    _initialCountdownMs = 0;
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
    // Do NOT reset _pomodoroCount here, so the cycle continues correctly
    if (_currentMode == TimerMode.pomodoro) {
      emit(
        TimerState.initialPomodoro().copyWith(
          hideMilliseconds: state.hideMilliseconds,
          phase: TimerPhase.pomodoro,
        ),
      );
    } else if (_currentMode == TimerMode.stopwatch) {
      emit(
        TimerState.initialStopwatch().copyWith(
          hideMilliseconds: state.hideMilliseconds,
          phase: TimerPhase.stopwatch,
        ),
      );
    } else {
      emit(
        TimerState.initialShortBreak().copyWith(
          hideMilliseconds: state.hideMilliseconds,
          phase: TimerPhase.shortBreak,
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
      // Switch back to pomodoro
      _currentMode = TimerMode.pomodoro;
      emit(
        TimerState.initialPomodoro().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
    } else {
      // Switch to short break
      _currentMode = TimerMode.pomodoro;
      emit(
        TimerState.initialShortBreak().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
    }
  }

  void _onLongBreakRequested(
    TimerLongBreakRequested event,
    Emitter<TimerState> emit,
  ) {
    _timer?.cancel();
    _countUpMilliseconds = 0;
    if (state.phase == TimerPhase.longBreak) {
      // Switch back to pomodoro
      _currentMode = TimerMode.pomodoro;
      emit(
        TimerState.initialPomodoro().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
      return;
    } else {
      emit(
        TimerState.initialLongBreak().copyWith(
          hideMilliseconds: state.hideMilliseconds,
        ),
      );
    }
  }

  void _onPhaseCompleted(TimerPhaseCompleted event, Emitter<TimerState> emit) {
    // When short or long break is completed, switch to pomodoro
    _currentMode = TimerMode.pomodoro;
    if (state.phase == TimerPhase.longBreak) {
      _pomodoroCount = 0; // Reset after long break only
    }
    emit(
      TimerState.initialPomodoro().copyWith(
        hideMilliseconds: state.hideMilliseconds,
      ),
    );
    // No auto-start here
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
