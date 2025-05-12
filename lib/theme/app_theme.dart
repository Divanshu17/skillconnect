import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
      secondary: const Color(0xFF0EA5E9),
      tertiary: const Color(0xFFF59E0B),
    ),
    // Add more theme customizations
  );

  static const gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2563EB),
      Color(0xFF0EA5E9),
    ],
  );

  // Add more gradients and styles
}
