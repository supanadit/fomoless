import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );

  sl.registerLazySingleton<WindowsInitializationSettings>(
    () => WindowsInitializationSettings(
      appName: 'Fomoless',
      appUserModelId: 'com.supanadit.fomoless',
      guid: '800ef20a-ef23-4358-a674-d94ae675edd4',
    ),
  );

  sl.registerLazySingleton<InitializationSettings>(
    () => InitializationSettings(windows: sl<WindowsInitializationSettings>()),
  );
}
