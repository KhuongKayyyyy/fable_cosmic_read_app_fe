import 'package:flutter/material.dart';

class AppTheme {
  // static Color primaryColor = const Color(0xFFFFD1DC);
  static Color primaryColor = const Color(0xFFc2c16e);
  static Color secondaryColor = const Color.fromRGBO(226, 225, 168, 1);
  static Color iconColor = const Color(0xFFa1a159);
  static Color success = const Color(0xFF5BA092);
  static Color inkGrey = const Color(0xFFBEBAB3);
  static Color inkGreyDark = const Color(0xFF78746D);
  static Color inkGreyLight = const Color(0xFFF8F2EE);
  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: secondaryColor,
      ),
    );
  }
}
