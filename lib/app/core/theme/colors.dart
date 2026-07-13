import 'package:flutter/material.dart';

abstract class AppColors {
  static const seedColor = Color(0xFF063036);
  static const primary =Colors.black87;
  static const secondary = Color(0xFFD4AF37);
  static final  secondaryLigth = secondary.withValues(alpha: 0.2);

  static const error = Colors.red;
  static const success = Colors.green;
  static const warning = Colors.yellow;

  static const black = Colors.black;
  static const white = Colors.white;
  static final grey = Colors.grey.shade900;
  static final greyLigth = Colors.grey.shade800;
  static const bg = Colors.black87;
}