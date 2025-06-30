import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fomoless/di.dart';
import 'package:fomoless/features/timer/presentation/page/timer_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();

  await sl<FlutterLocalNotificationsPlugin>().initialize(
    sl<InitializationSettings>(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fomoless',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TimerPage(),
    );
  }
}
