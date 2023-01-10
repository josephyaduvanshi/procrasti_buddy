import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:procrasti_buddy/themes/myappthemes.dart';

class ThemeNotifier with ChangeNotifier {
  static final ThemeNotifier _singleton = ThemeNotifier._internal();
  bool _isDark = false;
  ThemeData _themeData = MyThemeData.themeDataLight;

  factory ThemeNotifier() {
    return _singleton;
  }

  ThemeNotifier._internal() {
    _isDark = _themeData == MyThemeData.themeDataDark;
    loadTheme();
  }

  ThemeData getTheme() => _themeData;
  bool isDark() => _isDark;

  setTheme(ThemeData theme) {
    _themeData = theme;
    _isDark = _themeData == MyThemeData.themeDataDark;
    saveTheme();
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == MyThemeData.themeDataLight
        ? MyThemeData.themeDataDark
        : MyThemeData.themeDataLight;
    _isDark = _themeData == MyThemeData.themeDataDark;
    saveTheme();
    notifyListeners();
  }

  Future<void> saveTheme() async {
    final box = await Hive.openBox('themes');
    await box.put('theme', _isDark ? 'dark' : 'light');
  }

  Future<void> loadTheme() async {
    final box = await Hive.openBox('themes');
    final theme = await box.get('theme');
    if (theme == 'dark') {
      _themeData = MyThemeData.themeDataDark;
    } else {
      _themeData = MyThemeData.themeDataLight;
    }
  }
}
