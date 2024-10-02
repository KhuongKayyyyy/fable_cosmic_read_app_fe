import 'package:flutter/material.dart';
import 'dart:ui';

class AppTheme {
  static Color primaryColor = const Color(0xFFFFD1DC);
  static Color secondaryColor = const Color(0xFFFFD1DC);
  static Color success = const Color(0xFF5BA092);
  static Color inkGrey = const Color(0xFFBEBAB3);
  static Color inkGreyDark = const Color(0xFF78746D);
  static Color inkGreyLight = const Color(0xFFF8F2EE);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: secondaryColor,
      ),
    );
  }
}
