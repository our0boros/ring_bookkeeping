import 'package:flutter/material.dart';

class AppThemeData {
  final Color primaryColor; // 主要颜色
  final Color accentColor; // 强调颜色
  final Color backgroundColor; // 背景颜色
  final Color subBackgroundColor; // 副背景颜色
  final Color mainTextColor; // 主要文字颜色
  final Color subTextColor; // 副文字颜色
  final Color invertTextColor; // 反向文字颜色
  // ...

  const AppThemeData({
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.subBackgroundColor,
    required this.mainTextColor,
    required this.subTextColor,
    required this.invertTextColor,
    // ...
  });
}



const AppThemeData lightTheme = AppThemeData(
  primaryColor: Colors.blue,
  accentColor: Colors.blueAccent,
  backgroundColor: Color(0xffE9E5E5),
  subBackgroundColor: Color(0xffF6F6F6),
  mainTextColor: Colors.black,
  subTextColor: Colors.black54,
  invertTextColor: Colors.white,
  // ...
);

const AppThemeData darkTheme = AppThemeData(
  primaryColor: Colors.yellow,
  accentColor: Colors.yellowAccent,
  backgroundColor: Color(0xff282828),
  subBackgroundColor: Color(0xff282828),
  mainTextColor: Colors.white,
  subTextColor: Colors.white60,
  invertTextColor: Colors.black,
  // ...
);

