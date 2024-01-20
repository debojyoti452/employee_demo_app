import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

import 'app_theme.dart';
import 'app_theme_extension.dart';

abstract class AppTypography {
  static TextStyle displayLarge = GoogleFonts.roboto(
    fontSize: 112,
    fontWeight: FontWeight.w300,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle displayMedium = GoogleFonts.roboto(
    fontSize: 56,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle displaySmall = GoogleFonts.roboto(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle bodyLarge = GoogleFonts.roboto(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle labelLarge = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle labelMedium = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle labelSmall = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle headlineLarge = GoogleFonts.roboto(
    fontSize: 40,
    fontWeight: FontWeight.w300,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle headlineMedium = GoogleFonts.roboto(
    fontSize: 34,
    fontWeight: FontWeight.w300,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle headlineSmall = GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle titleLarge = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle titleMedium = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );

  static TextStyle titleSmall = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightAppColors.onPrimary,
  );
}
