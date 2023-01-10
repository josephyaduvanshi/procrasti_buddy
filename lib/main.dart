import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:procrasti_buddy/services/notifiers/home_page_notifier.dart';
import 'package:provider/provider.dart';

import 'database/task_manager/task_manager.dart';
import 'database/task_manager/task_service.dart';
import 'routes/route_deeplink.dart';
import 'routes/route_names.dart';
import 'services/notifiers/theme_notifiers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(TaskAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Task>('tasks');
  ThemeNotifier themeNotifier = ThemeNotifier();
  await themeNotifier.loadTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>.value(
          value: themeNotifier,
          child: const ProcrastiBuddyApp(),
        ),
        ChangeNotifierProvider<TaskCRUDNotifer>(
          create: (_) => TaskCRUDNotifer(),
          child: const ProcrastiBuddyApp(),
        ),
      ],
      child: const ProcrastiBuddyApp(),
    ),
  );
}

class ProcrastiBuddyApp extends StatelessWidget {
  const ProcrastiBuddyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      routes: RoutesProcrastiBuddy.routes,
      initialRoute: RouteNames.homepage,
    );
  }
}
