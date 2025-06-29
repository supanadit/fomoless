import 'package:flutter_bloc/flutter_bloc.dart';

part 'mode_event.dart';
part 'mode_state.dart';

// This bloc consist for mode
// - Stopwatch
// - Pomodoro

enum TimerMode { stopwatch, pomodoro }

class ModeBloc extends Bloc<ModeEvent, ModeState> {
  ModeBloc() : super(ModeInitialState()) {
    on<ModeSwitchRequested>((event, emit) {
      emit(ModeSelectedState(event.mode));
    });
  }
}
