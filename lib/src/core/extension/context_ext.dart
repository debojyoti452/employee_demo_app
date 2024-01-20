import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/local/in_memory_cache.dart';
import '../di/di.dart';

extension ContextExt on BuildContext {
  // App Localizations
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  // Screen Width
  double get screenWidth => MediaQuery.of(this).size.width;

  // Screen Height
  double get screenHeight => MediaQuery.of(this).size.height;

  // Screen Orientation
  Orientation get screenOrientation => MediaQuery.of(this).orientation;

  // TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  // Google Fonts
  GoogleFonts get googleFonts => GoogleFonts();

  // SnackBar with default duration
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    if (message.isEmpty) return;
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  // InMemoryCache
  InMemoryCache get inMemoryCache => getIt<InMemoryCache>();

  // check if device is tablet or phone and set the size accordingly
  Size get designSize =>
      (MediaQuery.of(this).size.width < 600) ? const Size(375, 812) : const Size(768, 1024);

  // check if device is tablet or phone
  bool get isTablet => (MediaQuery.of(this).size.width < 600) ? false : true;
}

extension InterFont on TextStyle {
  // Inter Font
  TextStyle get inter => GoogleFonts.inter();
}
