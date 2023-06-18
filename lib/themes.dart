import 'package:flutter/material.dart';

final ThemeData lightTheme = (ThemeData.light().copyWith(
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.red),
    primaryColor: Colors.red,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.red,
    ),
    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
    outlinedButtonTheme:
        OutlinedButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.black))),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        labelStyle: TextStyle(fontSize: 18, fontFamily: 'Montserrat', color: Colors.black)),
    textTheme: TextTheme(
      labelLarge: TextStyle(fontSize: 18, fontFamily: 'Montserrat', color: Colors.black),
      titleLarge: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
      // standard TextField()
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Montserrat',
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Montserrat',
        fontStyle: FontStyle.italic,
        color: Colors.black.withAlpha(128),
      ),
      // used for dictionary error text in Online dicts
      labelSmall: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat', fontStyle: FontStyle.italic, color: Colors.black),
      // standard Text()
      bodyMedium: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat', color: Colors.black),
      // italic Text()
      bodyLarge: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat', fontStyle: FontStyle.italic, color: Colors.black),
      // Dictionary card, dictionary  name
      bodySmall: TextStyle(fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.black),
    ),
    colorScheme: ColorScheme(
      background: Colors.red.shade200,
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.white,
      secondary: Colors.red,
      onSecondary: Colors.red,
      error: Colors.red,
      onError: Colors.red,
      onBackground: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
    )));

final ThemeData darkTheme = ThemeData.dark().copyWith(
    cardColor: Colors.pink,
    scaffoldBackgroundColor: Color.fromARGB(255, 140, 40, 40),
    dialogBackgroundColor: Color.fromARGB(255, 150, 50, 50),
    outlinedButtonTheme:
        OutlinedButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
    textTheme: TextTheme(
      labelLarge: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
      titleLarge: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Montserrat',
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Montserrat',
        fontStyle: FontStyle.italic,
        color: Colors.white.withAlpha(128),
      ),
      // used for dictionary error text in Online dicts
      labelSmall: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Montserrat',
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat', color: Colors.white),
      // Dictionary card, dictionary  name
      bodySmall: TextStyle(fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.white),
    ),
    colorScheme: ColorScheme(
      background: Colors.red.shade200,
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.white,
      secondary: Colors.red,
      onSecondary: Colors.red,
      error: Colors.red,
      onError: Colors.red,
      onBackground: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
    ));
