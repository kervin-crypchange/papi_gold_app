import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/core/theme/index.dart';

extension TextThemeExtension on BuildContext {
  // * (default) TextTheme
  TextStyle get displayLarge => _baseStyle(57.sp, AppColors.primary.base);
  TextStyle get displayMedium => _baseStyle(45.sp, AppColors.primary.base);
  TextStyle get displaySmall => _baseStyle(36.sp, AppColors.primary.base);

  TextStyle get headlineLarge => _baseStyle(32.sp, AppColors.primary.base);
  TextStyle get headlineMedium => _baseStyle(28.sp, AppColors.primary.base);
  TextStyle get headlineSmall => _baseStyle(24.sp, AppColors.primary.base);

  TextStyle get titleLarge => _baseStyle(22.sp, AppColors.primary.base);
  TextStyle get titleMedium => _baseStyle(20.sp, AppColors.primary.base);
  TextStyle get titleSmall => _baseStyle(18.sp, AppColors.primary.base);

  TextStyle get labelLarge => _baseStyle(16.sp, AppColors.grey.base);
  TextStyle get labelMedium => _baseStyle(14.sp, AppColors.grey.base);
  TextStyle get labelSmall => _baseStyle(12.sp, AppColors.grey.base);

  TextStyle get bodyLarge => _baseStyle(16.sp, AppColors.black);
  TextStyle get bodyMedium => _baseStyle(14.sp, AppColors.black);
  TextStyle get bodySmall => _baseStyle(12.sp, AppColors.black);

  static TextStyle _baseStyle(double fontSize, Color color) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      // fontFamily: _fontFamily,
      // fontWeight: _defaultWeight,
    );
  }
}