import 'package:flutter/material.dart';

class MyThemeData {
  static final themeDataDark = ThemeData.dark(useMaterial3: true).copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade100,
      secondary: Colors.purple.shade100,
      onPrimary: Colors.white,
      onSecondary: const Color.fromARGB(255, 25, 19, 27),
      onBackground: Colors.white,
      onError: Colors.redAccent,
      onSurface: Colors.white,
      background: const Color.fromARGB(255, 22, 22, 22),
      error: Colors.red,
      surface: const Color.fromARGB(255, 24, 22, 28),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue[300],
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue[300],
    ),
  );

  static final themeDataLight = ThemeData.light(useMaterial3: true).copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: Colors.purple,
      secondary: Colors.blue.shade100,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      onSurface: Colors.black,
      background: Colors.white,
      error: Colors.red,
      surface: Colors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue[300],
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue[300],
    ),
  );
}
