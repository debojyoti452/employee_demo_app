import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_text_theme_extension.dart';
import 'app_theme_extension.dart';
import 'app_typography.dart';

class AppTheme extends Cubit<ThemeMode> {
  AppTheme() : super(ThemeMode.light);

  set themeMode(ThemeMode themeMode) {
    emit(themeMode);
  }

  //
  // Light theme
  //

  static final light = () {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      brightness: Brightness.light,
      extensions: [
        lightAppColors,
        lightTextTheme,
      ],
      appBarTheme: defaultTheme.appBarTheme.copyWith(
        color: lightAppColors.primary,
        foregroundColor: lightAppColors.onPrimary,
        iconTheme: IconThemeData(
          color: lightAppColors.onSecondary,
        ),
        titleTextStyle: AppTypography.titleMedium.copyWith(
          color: lightAppColors.secondary,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textTheme: defaultTheme.textTheme.copyWith(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
      ),
      colorScheme: defaultTheme.colorScheme.copyWith(
        primary: lightAppColors.primary,
        onPrimary: lightAppColors.onPrimary,
        secondary: lightAppColors.secondary,
        onSecondary: lightAppColors.onSecondary,
        error: lightAppColors.error,
        onError: lightAppColors.onError,
        background: lightAppColors.background,
        onBackground: lightAppColors.onBackground,
        surface: lightAppColors.surface,
        onSurface: lightAppColors.onSurface,
      ),
    );
  }();

  static AppTextThemeExtension lightTextTheme = AppTextThemeExtension(
    displayLarge: GoogleFonts.roboto(
      fontSize: 112,
      fontWeight: FontWeight.w300,
      color: lightAppColors.onPrimary,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: 56,
      fontWeight: FontWeight.w400,
      color: lightAppColors.onPrimary,
    ),
    displaySmall: GoogleFonts.roboto(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: lightAppColors.onPrimary,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontSize: 40,
      fontWeight: FontWeight.w300,
      color: lightAppColors.onPrimary,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 34,
      fontWeight: FontWeight.w300,
      color: lightAppColors.onPrimary,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: lightAppColors.onPrimary,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: lightAppColors.onPrimary,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: lightAppColors.onPrimary,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: lightAppColors.onPrimary,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: lightAppColors.onPrimary,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: lightAppColors.onPrimary,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: lightAppColors.onPrimary,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: lightAppColors.onPrimary,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: lightAppColors.onPrimary,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: lightAppColors.onPrimary,
    ),
  );

  static final lightAppColors = AppColorsExtension(
    primary: const Color(0xff1DA1F2),
    onPrimary: Colors.black,
    secondary: const Color(0xffEDF8FF),
    onSecondary: Colors.white,
    error: const Color(0xffb00020),
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: const Color(0xffE5E5E5),
    scaffoldBackgroundColor: const Color(0xffF2F2F2),
  );

  //
  // Dark theme
  //

  static final dark = () {
    final defaultTheme = ThemeData.dark();

    return defaultTheme.copyWith(
      brightness: Brightness.dark,
      extensions: [
        darkAppColors,
        darkTextTheme,
      ],
      appBarTheme: defaultTheme.appBarTheme.copyWith(
        color: lightAppColors.primary,
        iconTheme: IconThemeData(
          color: lightAppColors.onSecondary,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.titleMedium.copyWith(
          color: darkAppColors.secondary,
        ),
      ),
      textTheme: defaultTheme.textTheme.copyWith(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
      ),
      colorScheme: defaultTheme.colorScheme.copyWith(
        primary: darkAppColors.primary,
        onPrimary: darkAppColors.onPrimary,
        secondary: darkAppColors.secondary,
        onSecondary: darkAppColors.onSecondary,
        error: darkAppColors.error,
        onError: darkAppColors.onError,
        background: darkAppColors.background,
        onBackground: darkAppColors.onBackground,
        surface: darkAppColors.surface,
        onSurface: darkAppColors.onSurface,
      ),
    );
  }();

  static AppTextThemeExtension darkTextTheme = AppTextThemeExtension(
    displayLarge: GoogleFonts.roboto(
      fontSize: 112,
      fontWeight: FontWeight.w300,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: 56,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: GoogleFonts.roboto(
      fontSize: 45,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontSize: 40,
      fontWeight: FontWeight.w300,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 34,
      fontWeight: FontWeight.w300,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
  );

  static final darkAppColors = AppColorsExtension(
    primary: const Color(0xff1DA1F2),
    onPrimary: Colors.black,
    secondary: const Color(0xffEDF8FF),
    onSecondary: Colors.black,
    error: const Color(0xffb00020),
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    scaffoldBackgroundColor: Colors.black,
  );
}

extension AppThemeExtension on ThemeData {
  AppColorsExtension get appColors => extension<AppColorsExtension>() ?? AppTheme.lightAppColors;

  AppTextThemeExtension get appTextTheme =>
      extension<AppTextThemeExtension>() ?? AppTheme.lightTextTheme;
}
