import 'package:flutter/material.dart';
import 'package:procrasti_buddy/routes/route_names.dart';
import 'package:procrasti_buddy/views/home_page.dart';
import 'package:procrasti_buddy/views/menu/pages/appointments_page.dart';
import 'package:procrasti_buddy/views/menu/pages/bills_and_payments.dart';
import 'package:procrasti_buddy/views/menu/pages/journal_page/journal_page.dart';
import 'package:procrasti_buddy/views/menu/pages/pomodoro_page.dart';
import 'package:procrasti_buddy/views/menu/pages/shopping_page.dart';
import 'package:procrasti_buddy/views/menu/pages/task_page.dart';
import 'package:procrasti_buddy/views/menu/pages/tips_and_tricks_page.dart';
import 'package:procrasti_buddy/views/settings.dart';

import '../views/about_page.dart';

class RoutesProcrastiBuddy {
  static final routes = <String, WidgetBuilder>{
    RouteNames.homepage: (BuildContext context) => const HomePage(),
    RouteNames.aboutPage: (BuildContext context) => const AboutPage(),
    RouteNames.settingsPage: (BuildContext context) => const SettingsPage(),
    RouteNames.appointmentPage: (BuildContext context) =>
        const AppointmentsPage(),
    RouteNames.taskPage: (BuildContext context) => const TaskPage(),
    RouteNames.billsAndPaymentPage: (BuildContext context) =>
        const BillsAndPaymentPage(),
    RouteNames.shoppingPage: (BuildContext context) => const ShoppingPage(),
    RouteNames.notesJournalPage: (BuildContext context) => JournalPage(),
    RouteNames.pomodoroPage: (BuildContext context) => const PomodoroPage(),
    RouteNames.tipsAndTrickPage: (BuildContext context) =>
        const TipsAndTricksPage(),
  };
}
