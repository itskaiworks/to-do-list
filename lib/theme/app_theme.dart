import 'package:flutter/material.dart';


class AppColors {
  static const Color primary = Color.fromARGB(255, 88, 80, 54);
  static const Color primaryDark = Color.fromARGB(255, 47, 49, 53);
  static const Color background = Color(0xFFF4F5FB);
  static const Color cardBackground = Colors.white;
  static const Color textDark = Color.fromARGB(255, 18, 18, 20);
  static const Color textMuted = Color.fromARGB(255, 80, 81, 90);
  static const Color chipBackground = Color(0xFFE9EBFB);
  static const Color success = Color(0xFF2E9E6B);
  static const Color danger = Color(0xFFE5484D);
  static const Color dangerSoft = Color(0xFFFDECEC);
}

class AppTheme {
  static const double cardRadius = 16;

  static ThemeData get lightTheme {
    final OutlineInputBorder normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFD5D8EE)),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.cardBackground,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: normalBorder,
        enabledBorder: normalBorder,
        focusedBorder: normalBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: normalBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: normalBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.danger, width: 2),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
