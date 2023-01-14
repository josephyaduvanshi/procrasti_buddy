import 'package:flutter/material.dart';
import 'package:procrasti_buddy/views/dashboard/dashboard_page.dart';
import 'package:procrasti_buddy/views/menu/menupage.dart';

import '../../views/ai_assistant/ai_assistant.dart';

class HomePageNotifier extends ChangeNotifier {
  final List<Widget> screens = [
    const DashBoardPage(),
    const ProcrastiBuddyAIPage(),
    const MenuPage(),
  ];

  int _currentNavigatonIndex = 0;

  int get currentNavigatonIndex => _currentNavigatonIndex;

  void changeIndex(int index) {
    _currentNavigatonIndex = index;
    notifyListeners();
  }

  void resetIndex() {
    _currentNavigatonIndex = 0;
    notifyListeners();
  }

  List<NavigationDestination> navigationDestinations = [
    NavigationDestination(
      icon: Icon(
        Icons.home,
        color: Colors.blue[500],
      ),
      label: 'Dashboard',
    ),
    NavigationDestination(
      icon: Icon(
        Icons.assistant_rounded,
        color: Colors.blue[500],
      ),
      label: 'Procrasti Buddy',
    ),
    NavigationDestination(
      icon: Icon(
        Icons.widgets_rounded,
        color: Colors.blue[500],
      ),
      label: 'Menu',
    ),
  ];

  List<PopupMenuItem> popupMenuItems = [
    const PopupMenuItem(
      value: 1,
      child: Text('Settings'),
    ),
    const PopupMenuItem(
      value: 2,
      child: Text('About'),
    ),
  ];
}
