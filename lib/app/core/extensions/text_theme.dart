import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

extension TextThemeExtension on BuildContext {
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  Color get accentColor => isDarkTheme
      ? AppColors.secondary
      : Theme.of(this).colorScheme.primary;

  Color get themeColor {
    return isDarkTheme
        ? AppColors.white
        : AppColors.black;
  }

  // * (default) TextTheme
  TextStyle get displayLarge => _baseStyle(38.sp, accentColor);
  TextStyle get displayMedium => _baseStyle(36.sp, accentColor);
  TextStyle get displaySmall => _baseStyle(34.sp, accentColor);

  TextStyle get headlineLarge => _baseStyle(32.sp, accentColor);
  TextStyle get headlineMedium => _baseStyle(28.sp, accentColor);
  TextStyle get headlineSmall => _baseStyle(24.sp, accentColor);

  TextStyle get titleLarge => _baseStyle(22.sp, accentColor);
  TextStyle get titleMedium => _baseStyle(20.sp, accentColor);
  TextStyle get titleSmall => _baseStyle(18.sp, accentColor);

  TextStyle get labelLarge => _baseStyle(16.sp, accentColor);
  TextStyle get labelMedium => _baseStyle(14.sp, accentColor);
  TextStyle get labelSmall => _baseStyle(12.sp, accentColor);
  TextStyle get labelXSmall => _baseStyle(10.sp, accentColor);

  TextStyle get bodyLarge => _baseStyle(16.sp, themeColor);
  TextStyle get bodyMedium => _baseStyle(14.sp, themeColor);
  TextStyle get bodySmall => _baseStyle(12.sp, themeColor);
  TextStyle get bodyXSmall => _baseStyle(10.sp, themeColor);

  static TextStyle _baseStyle(double fontSize, Color color) {
    return TextStyle(fontSize: fontSize, color: color);
  }
}
