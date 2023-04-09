
import 'package:flutter/material.dart';

import 'package:ring_bookkeeping/bottom_navigation.dart';
import 'package:ring_bookkeeping/pages/splash_page.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    initialRoute: '/',
    routes: {
      '/': (context) => SplashPage(),
      '/main': (context) => BottomNavigationBarWidget()
      }
    ));
}
