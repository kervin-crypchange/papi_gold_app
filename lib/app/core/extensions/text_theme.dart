import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/core/theme/index.dart';

extension TextThemeExtension on BuildContext {
  // * (default) TextTheme
  TextStyle get displayLarge => _baseStyle(57.sp, AppColors.secondary);
  TextStyle get displayMedium => _baseStyle(45.sp, AppColors.secondary);
  TextStyle get displaySmall => _baseStyle(36.sp, AppColors.secondary);

  TextStyle get headlineLarge => _baseStyle(32.sp, AppColors.secondary);
  TextStyle get headlineMedium => _baseStyle(28.sp, AppColors.secondary);
  TextStyle get headlineSmall => _baseStyle(24.sp, AppColors.secondary);

  TextStyle get titleLarge => _baseStyle(22.sp, AppColors.secondary);
  TextStyle get titleMedium => _baseStyle(20.sp, AppColors.secondary);
  TextStyle get titleSmall => _baseStyle(18.sp, AppColors.secondary);

  TextStyle get labelLarge => _baseStyle(16.sp, AppColors.white);
  TextStyle get labelMedium => _baseStyle(14.sp, AppColors.white);
  TextStyle get labelSmall => _baseStyle(12.sp, AppColors.white);
  TextStyle get labelXSmall => _baseStyle(10.sp, AppColors.white);

  TextStyle get bodyLarge => _baseStyle(16.sp, AppColors.white);
  TextStyle get bodyMedium => _baseStyle(14.sp, AppColors.white);
  TextStyle get bodySmall => _baseStyle(12.sp, AppColors.white);
  TextStyle get bodyXSmall => _baseStyle(10.sp, AppColors.white);

  static TextStyle _baseStyle(double fontSize, Color color) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      // fontFamily: _fontFamily,
      // fontWeight: _defaultWeight,
    );
  }
}