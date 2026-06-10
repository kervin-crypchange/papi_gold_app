import 'package:flutter/material.dart';

abstract class AppColors {
  static const seedColor = Color(0xFF063036);
  static const primary = _PrimaryColors();
  static const secondary = _SecondaryColors();
  static const tertiary = _TertiaryColors();

  static const error = _ErrorColors();
  static const success = _SuccessColors();
  static const warning = _WarningColors();

  static const black = Color(0xFF212121);
  static const white = Color(0xFFFFFFFF);
  static const grey = _GreyColors();

  static const surface = Color(0xFFF8F9FF);
  static const onSurface = Color(0xFF191C20);
  static const bg = Color(0xFFf6f8fa);
}

class _PrimaryColors {
  const _PrimaryColors();

  final base = const Color(0xFF043333);
  final dark = const Color(0xFF15210F);
  final light = const Color(0xFF7C9474);
}

class _SecondaryColors {
  const _SecondaryColors();

  final base = const Color(0xFF535F70);
  final dark = const Color(0xFF101C2B);
  final light = const Color(0xFFD7E3F7);
}

class _TertiaryColors {
  const _TertiaryColors();

  final base = const Color(0xFFCFAA61);
  final dark = const Color(0xFFb3833b);
  final light = const Color(0xFFfae8a8);
}

class _ErrorColors {
  const _ErrorColors();

  final base = const Color(0xFFBA1A1A);
  final dark = const Color(0xFF410002);
  final light = const Color(0xFFFFdAD6);
}

class _SuccessColors {
  const _SuccessColors();

  final base = const Color(0xFF66BB6A);
  final dark = const Color(0xFF43A047);
  final light = const Color(0xFFA5D6A7);
}

class _WarningColors {
  const _WarningColors();

  final base = const Color(0xFFFFFE58);
  final dark = const Color(0xFFFDD835);
  final light = const Color(0xFFFFF59D);
}

class _GreyColors {
  const _GreyColors();

  final base = const Color(0xFF73777F);
  final dark = const Color(0xFF43474E);
  final light = const Color(0xFFE1E2E8);
}