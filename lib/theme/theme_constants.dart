// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light theme
ThemeData lightThem = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 144, 220, 229),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 250, 250, 250),
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.black,
    background: Color.fromARGB(255, 228, 229, 241),
    onBackground: Colors.black,
    surface: Color.fromARGB(255, 210, 211, 219),
    onSurface: Colors.black,
    tertiary: Color.fromARGB(255, 147, 148, 165),
    onTertiary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 228, 229, 241),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  ),
  textTheme: GoogleFonts.montserratTextTheme(
    ThemeData(brightness: Brightness.dark).textTheme.copyWith(
        displayLarge:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyMedium: const TextStyle(fontSize: 16),
        labelLarge: const TextStyle(fontSize: 24)),
  ),
  useMaterial3: true,
);

// Dark theme
ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 144, 220, 229),
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 39, 71, 110),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Color.fromARGB(255, 0, 29, 74),
      onBackground: Colors.white,
      surface: Color.fromARGB(255, 39, 71, 110),
      onSurface: Colors.white,
      tertiary: Color.fromARGB(255, 0, 105, 146),
      onTertiary: Colors.white),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 0, 29, 74),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  ),
  textTheme: GoogleFonts.montserratTextTheme(
    ThemeData(brightness: Brightness.dark).textTheme.copyWith(
        displayLarge:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyMedium: const TextStyle(fontSize: 16),
        labelLarge: const TextStyle(fontSize: 24)),
  ),
  useMaterial3: true,
);
