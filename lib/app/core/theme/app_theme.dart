import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFD4AF37),
      iconTheme: IconThemeData(color: AppColors.white),
      actionsIconTheme: IconThemeData(color: AppColors.white),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(primary: Color(0xFFD4AF37)),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(primary: Color(0xFFD4AF37)),
  );

  // Holds the current theme mode state
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
}
