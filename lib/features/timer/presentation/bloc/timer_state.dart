part of 'timer_bloc.dart';

class TimerState {
  final int hours;
  final int minutes;
  final int seconds;
  final int milliseconds;
  final bool isRunning;
  final bool hideMilliseconds;

  TimerState({
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.milliseconds,
    required this.isRunning,
    required this.hideMilliseconds,
  });

  factory TimerState.initialStopwatch() => TimerState(
    hours: 0,
    minutes: 0,
    seconds: 0,
    milliseconds: 0,
    isRunning: false,
    hideMilliseconds: true,
  );

  factory TimerState.initialPomodoro() => TimerState(
    hours: 0,
    minutes: 25,
    seconds: 0,
    milliseconds: 0,
    isRunning: false,
    hideMilliseconds: true,
  );

  TimerState copyWith({
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    bool? isRunning,
    bool? hideMilliseconds,
  }) {
    return TimerState(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      milliseconds: milliseconds ?? this.milliseconds,
      isRunning: isRunning ?? this.isRunning,
      hideMilliseconds: hideMilliseconds ?? this.hideMilliseconds,
    );
  }
}
