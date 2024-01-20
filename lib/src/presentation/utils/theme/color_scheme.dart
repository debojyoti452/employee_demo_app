import 'package:flutter/material.dart';

mixin AppColor {

  static const Color lightTextColor = Color(0xFF949C9E);

  static MaterialColor greyColorPalette = const MaterialColor(
    0xFFE5E5E5,
    <int, Color>{
      50: Color(0xFFE5E5E5),
      100: Color(0xFFCCCCCC),
      200: Color(0xFFB2B2B2),
      300: Color(0xFF999999),
      400: Color(0xFF808080),
      500: Color(0xFF666666),
      600: Color(0xFF4D4D4D),
      700: Color(0xFF333333),
      800: Color(0xFF1A1A1A),
      900: Color(0xFF000000),
    },
  );
}
