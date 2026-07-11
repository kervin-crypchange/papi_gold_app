import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(primary: Colors.blue),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
    ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFD4AF37),
      brightness: Brightness.dark,
    ),
  );

  // Holds the current theme mode state
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
}

