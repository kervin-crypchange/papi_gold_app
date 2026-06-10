import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black26,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFD4AF37),
      brightness: Brightness.dark,
    ),
  );
}
