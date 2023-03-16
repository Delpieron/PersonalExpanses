import 'package:flutter/material.dart';

final ThemeData lightTheme = (ThemeData.light().copyWith(
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.red),
  primaryColor: Colors.red,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.red,
    ),
    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black))),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        labelStyle: TextStyle(
            fontSize: 18, fontFamily: 'Montserrat', color: Colors.black)),
    backgroundColor: Colors.red.shade200,
    textTheme: TextTheme(
      button: TextStyle(
          fontSize: 18, fontFamily: 'Montserrat', color: Colors.black),
      headline6: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
      // standard TextField()
      subtitle1: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Montserrat',
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Montserrat',
        fontStyle: FontStyle.italic,
        color: Colors.black.withAlpha(128),
      ),
      // used for dictionary error text in Online dicts
      overline: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontStyle: FontStyle.italic,
          color: Colors.black),
      // standard Text()
      bodyText2: TextStyle(
          fontSize: 20.0, fontFamily: 'Montserrat', color: Colors.black),
      // italic Text()
      bodyText1: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontStyle: FontStyle.italic,
          color: Colors.black),
      // Dictionary card, dictionary  name
      caption: TextStyle(
          fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.black),
    )));

final ThemeData darkTheme = ThemeData.dark().copyWith(
    cardColor: Colors.pink,
    scaffoldBackgroundColor: Color.fromARGB(255, 140, 40, 40),
    dialogBackgroundColor: Color.fromARGB(255, 150, 50, 50),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
    backgroundColor: Color.fromARGB(255, 150, 50, 50),
    textTheme: TextTheme(
      button: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
      headline6: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
      subtitle1: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Montserrat',
        color: Colors.white,
      ),
      subtitle2: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Montserrat',
        fontStyle: FontStyle.italic,
        color: Colors.white.withAlpha(128),
      ),
      // used for dictionary error text in Online dicts
      overline: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Montserrat',
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
          fontSize: 20.0, fontFamily: 'Montserrat', color: Colors.white),
      // Dictionary card, dictionary  name
      caption: TextStyle(
          fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.white),
    ));
