import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/theme/index.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bg,
    appBarTheme: AppBarTheme(
      color: AppColors.primary.base,
      titleTextStyle: TextStyle(color: AppColors.white, fontSize: 22),
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedColor),
    navigationBarTheme: NavigationBarThemeData(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      indicatorColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: AppColors.primary.base),
      headlineMedium: TextStyle(color: AppColors.primary.base),
      headlineSmall: TextStyle(color: AppColors.primary.base),
      displayLarge: TextStyle(color: AppColors.primary.base),
      displayMedium: TextStyle(color: AppColors.primary.base),
      displaySmall: TextStyle(color: AppColors.primary.base),
      titleLarge: TextStyle(color: AppColors.primary.dark),
      titleMedium: TextStyle(color: AppColors.primary.dark),
      titleSmall: TextStyle(color: AppColors.primary.dark),
      labelLarge: TextStyle(color: AppColors.grey.base),
      labelMedium: TextStyle(color: AppColors.grey.base),
      labelSmall: TextStyle(color: AppColors.grey.base),
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        // minimumSize: Size(10, 50),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(7),
        // ),
      ),
    ),
  );
}