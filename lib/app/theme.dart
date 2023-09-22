import 'package:flutter/material.dart';

class AppTheme {
  // Define your colors
  static const Color primaryColor = Colors.green;
  static const Color accentColor = Colors.greenAccent;

  // Define your text styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
  );

    static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
  );


  // Create a ThemeData instance
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      textTheme: const TextTheme(
        bodyLarge: bodyLarge,
        bodyMedium:  bodyText,
        titleLarge: headline1,
      ),
    );
  }
}
