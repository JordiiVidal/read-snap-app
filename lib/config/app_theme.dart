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

    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).apply(
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
      style:
          FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            iconSize: 24,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            elevation: 4,
            shadowColor: AppColors.primary.withValues(alpha: 0.5),
          ).copyWith(
            backgroundColor: WidgetStateProperty.all(AppColors.primary),
            elevation: WidgetStateProperty.all(4),
            shadowColor: WidgetStateProperty.all(
              AppColors.primary.withValues(alpha: 0.5),
            ),
          ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromARGB(255, 225, 225, 225),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: AppColors.error, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
      ),
      labelStyle: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      prefixIconColor: Colors.grey.shade600,
      suffixIconColor: Colors.grey.shade600,
      errorStyle: TextStyle(
        color: AppColors.error,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      errorMaxLines: 2,
    ),

    iconTheme: IconThemeData(color: AppColors.textPrimary),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      titleTextStyle: GoogleFonts.sora(
        textStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
