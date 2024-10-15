import 'package:flutter/material.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
    ),
  );
}
