part of 'timer_bloc.dart';

enum TimerPhase { pomodoro, shortBreak, longBreak, stopwatch }

class TimerState {
  final int hours;
  final int minutes;
  final int seconds;
  final int milliseconds;
  final bool isRunning;
  final bool hideMilliseconds;
  final TimerPhase phase;

  TimerState({
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.milliseconds,
    required this.isRunning,
    required this.hideMilliseconds,
    required this.phase,
  });

  factory TimerState.initialStopwatch() => TimerState(
    hours: 0,
    minutes: 0,
    seconds: 0,
    milliseconds: 0,
    isRunning: false,
    hideMilliseconds: true,
    phase: TimerPhase.stopwatch,
  );

  factory TimerState.initialPomodoro() => TimerState(
    hours: 0,
    minutes: 0,
    seconds: 2,
    milliseconds: 0,
    isRunning: false,
    hideMilliseconds: true,
    phase: TimerPhase.pomodoro,
  );

  factory TimerState.initialShortBreak() => TimerState(
    hours: 0,
    minutes: 0,
    seconds: 2,
    milliseconds: 0,
    isRunning: false,
    hideMilliseconds: true,
    phase: TimerPhase.shortBreak,
  );

  factory TimerState.initialLongBreak() => TimerState(
    hours: 0,
    minutes: 0,
    seconds: 3,
    milliseconds: 0,
    isRunning: false,
    hideMilliseconds: true,
    phase: TimerPhase.longBreak,
  );

  TimerState copyWith({
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    bool? isRunning,
    bool? hideMilliseconds,
    TimerPhase? phase,
  }) {
    return TimerState(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      milliseconds: milliseconds ?? this.milliseconds,
      isRunning: isRunning ?? this.isRunning,
      hideMilliseconds: hideMilliseconds ?? this.hideMilliseconds,
      phase: phase ?? this.phase,
    );
  }
}
