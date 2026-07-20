import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFD4AF37),
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.white),
      actionsIconTheme: IconThemeData(color: AppColors.white),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(primary: Color(0xFFD4AF37)),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.secondary),
      trackOutlineColor: WidgetStateProperty.all(Color(0xFFE7E0E8)),
      trackColor: WidgetStateProperty.all(Color(0xFFE7E0E8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors
              .secondary; // Or Theme.of(context).colorScheme.primary
        }
        return AppColors.black;
      }),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary),
      ),
    ),
    dialogTheme: DialogThemeData(
      surfaceTintColor: Color.fromARGB(255, 95, 95, 95),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.grey),
    scaffoldBackgroundColor: AppColors.grey,
    colorScheme: const ColorScheme.dark(primary: Color(0xFFD4AF37)),
    dialogTheme: DialogThemeData(backgroundColor: AppColors.grey),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.white),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.grey,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      constraints: BoxConstraints(
        maxWidth: 600, // Useful for tablets/web
      ),
      showDragHandle: true, // Adds a top grabber handle
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(foregroundColor: AppColors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.secondary;
        }
        return AppColors.white;
      }),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary),
      ),
    ),
  );

  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
}
