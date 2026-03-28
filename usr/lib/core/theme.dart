import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF1D9E75);
  static const Color lightGreen = Color(0xFFE1F5EE);
  static const Color darkGreen = Color(0xFF085041);
  static const Color blue = Color(0xFF378ADD);
  static const Color amber = Color(0xFFBA7517);
  static const Color red = Color(0xFFE24B4A);
  static const Color purple = Color(0xFF7F77DD);
  static const Color bgGray = Color(0xFFF1EFE8);
  static const Color textDark = Color(0xFF2C2C2A);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: bgGray,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: amber,
        error: red,
        surface: bgGray,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textDark),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textDark),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: textDark),
        labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textDark),
      ),
    );
  }
}
