import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_test/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  primarySwatch: defaultcolor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: HexColor('333739'),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.orange,
  ),
  fontFamily: 'Jannah'
);
ThemeData lightTheme = ThemeData(
  primarySwatch: defaultcolor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.orange,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah'
);