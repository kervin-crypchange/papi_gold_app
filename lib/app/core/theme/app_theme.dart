import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFD4AF37),
      brightness: Brightness.dark,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
    ),
    navigationBarTheme: NavigationBarThemeData(
      // overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      //   return Colors.transparent;
      // }),
      indicatorColor: Colors.transparent,
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.secondary);
        }
        return const IconThemeData();
      }),
    ),
  );
}
