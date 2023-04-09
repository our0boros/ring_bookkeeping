import 'package:flutter/material.dart';

class AppThemeData {
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  // ...

  const AppThemeData({
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
    // ...
  });
}



const AppThemeData lightTheme = AppThemeData(
  primaryColor: Colors.blue,
  accentColor: Colors.blueAccent,
  backgroundColor: Colors.white,
  // ...
);

const AppThemeData darkTheme = AppThemeData(
  primaryColor: Colors.yellow,
  accentColor: Colors.yellowAccent,
  backgroundColor: Colors.black,
  // ...
);

