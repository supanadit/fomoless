part of 'mode_bloc.dart';

abstract class ModeEvent {}

// Renamed to avoid duplicate definition
class ModeSwitchRequested extends ModeEvent {
  final TimerMode mode;
  ModeSwitchRequested(this.mode);
}
