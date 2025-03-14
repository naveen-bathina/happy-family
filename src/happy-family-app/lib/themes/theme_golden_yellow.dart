import 'package:flutter/material.dart';

class AppTheme {
  static const Color rose = Color(0xFFFF007F);
  static const Color goldYellow = Color(0xFFFFD700);
  static const Color cyanBlue = Color(0xFF00AEEF);
  static const Color purple = Color(0xFF800080);
  static const Color lightYellow = Color(0xFFFFE4B5);
  static const Color lightCream = Color(0xFFFFF8E1);
  static const Color charcoalGray = Color(0xFF333333);
  static const Color amber = Color(0xFFFFC107);

  static ThemeData lightTheme(BuildContext context) => ThemeData(
    primaryColor: goldYellow,
    scaffoldBackgroundColor: lightCream,
    colorScheme: ColorScheme.light(
      primary: goldYellow,
      secondary: lightYellow,
      surface: lightCream,
      onPrimary: Colors.white,
      onSecondary: charcoalGray,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: goldYellow,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: charcoalGray,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: charcoalGray,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        color: charcoalGray,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        color: charcoalGray,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: charcoalGray,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: amber,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: goldYellow),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightYellow),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: goldYellow,
      selectedItemColor: lightYellow,
      unselectedItemColor: Colors.white70,
    ),
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    primaryColor: purple,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: purple,
      secondary: cyanBlue,
      surface: Colors.grey[900]!,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: purple,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: Theme.of(
      context,
    ).textTheme.apply(bodyColor: Colors.white, displayColor: goldYellow),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cyanBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: goldYellow,
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: purple,
      selectedItemColor: cyanBlue,
      unselectedItemColor: Colors.white70,
    ),
  );
}
