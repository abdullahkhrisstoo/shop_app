import 'package:flutter/material.dart';
import 'package:project1/constant/colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: ConstantColor.primaryColor,
  focusColor: ConstantColor.primaryColor,
  iconTheme: IconThemeData(
    color: ConstantColor.secondeyColor,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightThemeColor.primaryColor,
    elevation: 5.0,
    selectedItemColor: ConstantColor.primaryColor,
    unselectedItemColor: ConstantColor.secondeyColor,
  ),
  scaffoldBackgroundColor: LightThemeColor.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: LightThemeColor.primaryColor,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: ConstantColor.primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
    ),
    actionsIconTheme: IconThemeData(
      color: ConstantColor.primaryColor,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: ConstantColor.primaryColor,
  iconTheme: IconThemeData(
    color: ConstantColor.secondeyColor,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: DarkThemeColor.primaryColor,
    elevation: 5.0,
    selectedItemColor: ConstantColor.primaryColor,
    unselectedItemColor: ConstantColor.secondeyColor,
  ),
  scaffoldBackgroundColor: DarkThemeColor.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: DarkThemeColor.primaryColor,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: ConstantColor.primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
    ),
    actionsIconTheme: IconThemeData(
      color: ConstantColor.primaryColor,
    ),
  ),
);
