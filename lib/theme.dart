import 'package:flutter/material.dart';

class AppThemeData {
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color mainTextColor;
  final Color subTextColor;
  final Color invertTextColor;
  // ...

  const AppThemeData({
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.mainTextColor,
    required this.subTextColor,
    required this.invertTextColor,
    // ...
  });
}



const AppThemeData lightTheme = AppThemeData(
  primaryColor: Colors.blue,
  accentColor: Colors.blueAccent,
  backgroundColor: Colors.white,
  mainTextColor: Colors.black,
  subTextColor: Colors.black54,
  invertTextColor: Colors.white,
  // ...
);

const AppThemeData darkTheme = AppThemeData(
  primaryColor: Colors.yellow,
  accentColor: Colors.yellowAccent,
  backgroundColor: Colors.black,
  mainTextColor: Colors.white,
  subTextColor: Colors.white60,
  invertTextColor: Colors.black,
  // ...
);

