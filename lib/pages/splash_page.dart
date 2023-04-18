import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ring_bookkeeping/appThemes.dart';
import 'package:ring_bookkeeping/main_navigation.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  // 加载时长默认
  final int _welcomeSkipper = 3;
  //  环 加载条
  late AnimationController controller;
  late Animation<double> animation;

  final String logoName = 'assets/images/RING.png';
  final String logoDarkName = 'assets/images/RING-dark.png';

  //  计时器
  late Timer timer;
  // 主题模式
  bool isDarkMode = true;
  bool skipSplash = true;

  void getPrefsSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isDarkMode") == null) {
      prefs.setBool("isDarkMode", false);
    }
    if (prefs.getBool("skipSplash") == null) {
      prefs.setBool("skipSplash", true);
    }

    setState(() {
      isDarkMode = prefs.getBool("isDarkMode")!;
      skipSplash = prefs.getBool("skipSplash")!;
    });
  }


  @override
  void initState() {
    super.initState();
    // 主题模式获取
    getPrefsSettings();
    // 动画控制
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2100),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    animation = Tween(
      begin: -0.001388,
      end: 0.08611,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));

    // 自动跳转
    if (!skipSplash) {
      timer = Timer(Duration(seconds: _welcomeSkipper), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavigationBarWidget()));
      });
    }

  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double ringSize = MediaQuery.of(context).size.width * 0.5;
    // print(animation.value);
    return Material(
      color: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: ringSize/2),
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: animation.value * 2 * pi,
                child: Image(
                  image: AssetImage(isDarkMode ? logoName : logoDarkName),
                  width: ringSize,
                  height: ringSize,
                ),
              );
            },
          )
        )
      )

    );
  }
}