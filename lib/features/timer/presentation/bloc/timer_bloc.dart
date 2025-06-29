import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerState.initial()) {
    on<TimerStarted>((event, emit) {
      if (state.isRunning) {
        _timer?.cancel();
        emit(state.copyWith(isRunning: false));
      } else {
        emit(state.copyWith(isRunning: true));
        _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
          add(
            TimerTicked(
              hours: state.hours,
              minutes: state.minutes,
              seconds: state.seconds,
              milliseconds: state.milliseconds + 10,
            ),
          );
        });
      }
    });

    on<TimerStopped>((event, emit) {
      _timer?.cancel();
      emit(state.copyWith(isRunning: false));
    });

    on<TimerReset>((event, emit) {
      _timer?.cancel();
      emit(TimerState.initial());
    });

    on<TimerTicked>((event, emit) {
      int ms = event.milliseconds;
      int s = event.seconds;
      int m = event.minutes;
      int h = event.hours;
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
      emit(state.copyWith(hours: h, minutes: m, seconds: s, milliseconds: ms));
    });

    on<TimerToggleMilliseconds>((event, emit) {
      emit(state.copyWith(hideMilliseconds: !state.hideMilliseconds));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
