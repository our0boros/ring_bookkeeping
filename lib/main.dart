
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ring_bookkeeping/main_navigation.dart';
import 'package:ring_bookkeeping/pages/splash_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('skipSplash') == null) {
    prefs.setBool('skipSplash', false);
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    initialRoute: prefs.getBool('skipSplash')! ? '/main' : '/',
    routes: {
      '/': (context) => const SplashPage(),
      '/main': (context) => const BottomNavigationBarWidget()
      },

    ));
}

