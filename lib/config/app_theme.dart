import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_snap/config/app_colors.dart';

class AppTheme {
  static final ColorScheme _colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryVariant,
    secondary: AppColors.secondary,
    error: AppColors.error,
    surface: AppColors.surface,

    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimary,
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: _colorScheme,

    scaffoldBackgroundColor: AppColors.background,

    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
      selectedColor: AppColors.primary,
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(color: AppColors.textPrimary),
      side: BorderSide(color: AppColors.border),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderFocus, width: 1.3),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 1.0),
      ),
      hintStyle: TextStyle(color: AppColors.textSecondary),
    ),

    iconTheme: IconThemeData(color: AppColors.textPrimary),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      titleTextStyle: GoogleFonts.inter(
        textStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
