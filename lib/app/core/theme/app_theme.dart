import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

class AppThemes {
  static const defaultThemeMode = ThemeMode.dark;

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFD4AF37),
      foregroundColor: AppColors.black,
      iconTheme: IconThemeData(color: AppColors.black),
      actionsIconTheme: IconThemeData(color: AppColors.black),
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF765800),
      onPrimary: AppColors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.black,
      surface: AppColors.white,
      onSurface: AppColors.black,
      outline: Color(0xFF666666),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Color(0xFF765800)),
      trackOutlineColor: WidgetStateProperty.all(Color(0xFFE7E0E8)),
      trackColor: WidgetStateProperty.all(Color(0xFFE7E0E8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return Color(0xFF765800);
        }
        return AppColors.black;
      }),
      border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF765800))),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.grey,
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.white),
      actionsIconTheme: IconThemeData(color: AppColors.white),
    ),
    scaffoldBackgroundColor: AppColors.grey,
    colorScheme: ColorScheme.dark(
      primary: AppColors.secondary,
      onPrimary: AppColors.black,
      secondary: AppColors.secondary,
      onSecondary: AppColors.black,
      surface: AppColors.grey,
      onSurface: AppColors.white,
      outline: Color(0xFFBDBDBD),
    ),
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
      style: FilledButton.styleFrom(
        foregroundColor: AppColors.black,
        backgroundColor: AppColors.secondary,
      ),
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
    defaultThemeMode,
  );

  static Future<void> loadThemeMode() async {
    final config = Hive.box(BoxEnum.config.name);
    final savedMode = config.get(BoxEnum.config.themeMode);
    final mode = ThemeMode.values.firstWhere(
      (value) => value.name == savedMode,
      orElse: () => defaultThemeMode,
    );
    themeModeNotifier.value = mode;
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    final previousMode = themeModeNotifier.value;
    themeModeNotifier.value = mode;
    try {
      await Hive.box(BoxEnum.config.name).put(BoxEnum.config.themeMode, mode.name);
    } catch (_) {
      themeModeNotifier.value = previousMode;
      rethrow;
    }
  }

  static SystemUiOverlayStyle systemUiOverlayStyle(ThemeMode mode) {
    final iconBrightness = mode == ThemeMode.dark
        ? Brightness.light
        : Brightness.dark;
    return SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: iconBrightness,
      statusBarColor: Colors.transparent,
      statusBarBrightness: mode == ThemeMode.dark
          ? Brightness.dark
          : Brightness.light,
      statusBarIconBrightness: iconBrightness,
    );
  }
}
