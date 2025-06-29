part of 'mode_bloc.dart';

abstract class ModeState {
  TimerMode get mode;
}

// Renamed to avoid duplicate definition
class ModeInitialState extends ModeState {
  @override
  final TimerMode mode;
  ModeInitialState({this.mode = TimerMode.pomodoro});
}

class ModeSelectedState extends ModeState {
  @override
  final TimerMode mode;
  ModeSelectedState(this.mode);
}
