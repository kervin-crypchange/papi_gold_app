import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/theme/index.dart';

class StatusColor {
  static Color color(String status, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return switch (status) {
      'warning' => isDark ? const Color(0xFFFFB74D) : const Color(0xFF8A5A00),
      'info' => isDark ? const Color(0xFF90CAF9) : const Color(0xFF0057B8),
      'primary' => isDark ? const Color(0xFFFFD54F) : const Color(0xFF765800),
      'danger' => isDark ? const Color(0xFFEF9A9A) : const Color(0xFFB3261E),
      'gray' => isDark ? const Color(0xFFBDBDBD) : const Color(0xFF595959),
      'success' => isDark ? const Color(0xFFA5D6A7) : const Color(0xFF1B5E20),
      _ => isDark ? AppColors.white : AppColors.black,
    };
  }
}
