part of 'timer_bloc.dart';

abstract class TimerEvent {}

class TimerStarted extends TimerEvent {}

class TimerStopped extends TimerEvent {}

class TimerReset extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final int hours;
  final int minutes;
  final int seconds;
  final int milliseconds;
  TimerTicked({
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.milliseconds,
  });
}

class TimerToggleMilliseconds extends TimerEvent {}

class TimerModeChanged extends TimerEvent {
  final TimerMode mode;
  TimerModeChanged(this.mode);
}

class TimerShortBreakRequested extends TimerEvent {}
