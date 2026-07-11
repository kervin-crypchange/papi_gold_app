import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(primary: Colors.blue),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(primary: Colors.indigo),
  );

  // Holds the current theme mode state
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.light,
  );
}

// ThemeData appTheme() {
//   return ThemeData(
//     useMaterial3: true,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.grey.shade900,
//     ),
//     scaffoldBackgroundColor: Colors.grey.shade900,
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: Color(0xFFD4AF37),
//       brightness: Brightness.dark,
//     ),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//       shape: CircleBorder(),
//     ),
//     navigationBarTheme: NavigationBarThemeData(
//       indicatorColor: Colors.transparent,
//       iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
//         if (states.contains(WidgetState.selected)) {
//           return const IconThemeData(color: AppColors.secondary);
//         }
//         return const IconThemeData();
//       }),
//     ),
//   );
// }
