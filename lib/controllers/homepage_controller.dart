import 'package:flutter/material.dart';

class HomePageController {
  static List<PopupMenuItem> popUpMenuItems = [
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
