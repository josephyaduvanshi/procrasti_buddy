import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:procrasti_buddy/database/database_config.dart';
import 'package:provider/provider.dart';

import 'routes/route_deeplink.dart';
import 'routes/route_names.dart';
import 'services/notifications/notifications_helper.dart';
import 'services/notifiers/theme_notifiers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseConfig.initializeDatabase();
  await dotenv.load(fileName: ".env");
  await NotificationApi.init();
  ThemeNotifier themeNotifier = ThemeNotifier();
  await themeNotifier.loadTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>.value(
          value: themeNotifier,
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
