import 'package:flutter/material.dart';
import 'package:procrasti_buddy/routes/route_names.dart';
import 'package:procrasti_buddy/views/home_page.dart';
import 'package:procrasti_buddy/views/settings.dart';

import '../views/about_page.dart';

class RoutesProcrastiBuddy {
  static final routes = <String, WidgetBuilder>{
    RouteNames.homepage: (BuildContext context) => const HomePage(),
    RouteNames.aboutPage: (BuildContext context) => const AboutPage(),
    RouteNames.settingsPage: (BuildContext context) => const SettingsPage(),
  };
}
