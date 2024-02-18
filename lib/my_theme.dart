import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryColor = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffffffff);
  static Color blackColor = Color(0xff383838);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color grayColor = Color(0xffa29b9b);
  static Color backgroundLightColor = Color(0xffDFECDB);
  static Color backgroundDarkColor = Color(0xff060E1E);
  static Color blackDarkColor = Color(0xff141922);

  static ThemeData lightMode = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: grayColor,
        backgroundColor: Colors.transparent,
        elevation: 0
    ),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
            side: BorderSide(
                color: primaryColor,
                width: 2
            )
        )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        shape: StadiumBorder(
            side: BorderSide(
              color: whiteColor,
              width: 3,
            )
        )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: whiteColor),
      titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: blackColor),
      titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: blackColor),
    ),
  );
  static ThemeData darkMode = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundDarkColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: grayColor,
          backgroundColor: blackDarkColor,
          elevation: 0
      ),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
              side: BorderSide(
                  color: primaryColor,
                  width: 2
              )
          )
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          shape: StadiumBorder(
              side: BorderSide(
                color: whiteColor,
                width: 3,
              )
          )
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: whiteColor),
          titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: blackColor),
          titleSmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: blackColor),
          ),
      );
}
