import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fomoless/di.dart';
import 'package:fomoless/features/timer/presentation/bloc/mode_bloc.dart';
import 'package:fomoless/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:fomoless/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();

  await sl<FlutterLocalNotificationsPlugin>().initialize(
    sl<InitializationSettings>(),
  );
  runApp(
    BlocProvider(
      create: (_) => ModeBloc(),
      child: BlocBuilder<ModeBloc, ModeState>(
        builder: (context, modeState) {
          return BlocProvider(
            create: (_) => TimerBloc(modeState.mode),
            child: BlocListener<ModeBloc, ModeState>(
              listener: (context, modeState) {
                context.read<TimerBloc>().add(TimerModeChanged(modeState.mode));
              },
              child: const FomolessApp(),
            ),
          );
        },
      ),
    ),
  );
}

class FomolessApp extends StatelessWidget {
  const FomolessApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: routes);
  }
}
