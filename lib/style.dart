import 'package:flutter/material.dart';

var theme = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.yellow
    )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.red,
      primary: Colors.red,
    )
  ),
  iconTheme: IconThemeData(color: Colors.blue),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    actionsIconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
    elevation: 1,

  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.red,
  )
);