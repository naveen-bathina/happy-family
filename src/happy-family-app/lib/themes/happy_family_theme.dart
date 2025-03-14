import 'package:flutter/material.dart';

final ThemeData happyFamilyTheme = ThemeData(
  primaryColor: Color(0xFFFFBC8D), // Soft Peach
  hintColor: Color(0xFF8AC6D1), // Light Cream
  scaffoldBackgroundColor: Color(0xFFFFF5E1), // Light Cream
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFFFF6F61), // Coral Pink
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFF333333), // Charcoal Gray
    ),
    displayMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Color(0xFF333333),
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      color: Color(0xFF333333),
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      color: Color(0xFF333333),
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFF333333),
    ),
    labelMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xFF333333),
    ),
    labelSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Color(0xFF333333),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFBC8D), // Soft Peach
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white, // White icons in app bar
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF333333), // Charcoal Gray
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFF6F61), // Coral Pink
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFFBC8D)), // Soft Peach
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF8AC6D1)), // Sky Blue
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: Color(0xFFFF6F61),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ), colorScheme: ColorScheme.light(
    primary: Color(0xFFFFBC8D), // Soft Peach
    secondary: Color(0xFF8AC6D1), // Sky Blue
    onPrimary: Colors.white,
    onSecondary: Color(0xFF333333),
  ).copyWith(surface: Color(0xFFFFF5E1)),
);
