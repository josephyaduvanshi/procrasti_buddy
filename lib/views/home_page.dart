import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procrasti_buddy/controllers/homepage_controller.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../routes/route_names.dart';
import '../services/notifiers/home_page_notifier.dart';
import '../services/notifiers/theme_notifiers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.brightness == Brightness.dark;
    return ChangeNotifierProvider(
      create: (_) => HomePageNotifier(),
      child: Consumer(
          builder: (context, HomePageNotifier homePageNotifier, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          bottomNavigationBar: NavigationBar(
            elevation: 2,
            height: MediaQuery.of(context).size.height * 0.07,
            selectedIndex: homePageNotifier.currentNavigatonIndex,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: homePageNotifier.changeIndex,
            destinations: homePageNotifier.navigationDestinations,
          ),
          appBar: AppBar(
            elevation: 2,
            title: 'Hey There!'
                .text
                .textStyle(GoogleFonts.pacifico())
                .make()
                .pOnly(left: 10),
            actions: <Widget>[
              IconButton(
                icon: isDark
                    ? const Icon(Icons.lightbulb_outline)
                    : const Icon(Icons.dark_mode_outlined),
                onPressed: () {
                  final themeNotifier =
                      Provider.of<ThemeNotifier>(context, listen: false);
                  themeNotifier.toggleTheme();
                },
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_active_outlined),
              ),
              PopupMenuButton(
                enableFeedback: true,
                icon: const Icon(Icons.more_vert_rounded),
                onSelected: (value) {
                  Map<int, dynamic> pages = {
                    1: () =>
                        Navigator.pushNamed(context, RouteNames.settingsPage),
                    2: () => Navigator.pushNamed(context, RouteNames.aboutPage)
                  };
                  pages[value]();
                },
                elevation: 3,
                splashRadius: 10,
                position: PopupMenuPosition.under,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                itemBuilder: (context) => HomePageController.popUpMenuItems,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          body:
              homePageNotifier.screens[homePageNotifier.currentNavigatonIndex],
        );
      }),
    );
  }
}
