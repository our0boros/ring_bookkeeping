import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ring_bookkeeping/theme.dart';
import 'package:ring_bookkeeping/bottom_navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  // 加载时长默认
  int _welcomeSkipper = 3;
  //  环 加载条
  late AnimationController controller;
  bool determinate = false;
  //  计时器
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _loadCounter();
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: _welcomeSkipper),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    timer = Timer(Duration(seconds: _welcomeSkipper), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavigationBarWidget()));
    });
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getInt('welcome_skipper') == null) {
        prefs.setInt('welcome_skipper', 3);
      }
      _welcomeSkipper = prefs.getInt('welcome_skipper')!;

    });
  }

  @override
  Widget build(BuildContext context) {
    final double ringSize = MediaQuery.of(context).size.width * 0.5;
    return Material(
      color: darkTheme.backgroundColor,
      child: Center(
        child: Stack(
          children: <Widget> [
            Center(
              // child: CustomCircularProgressIndicator(size: ringSize,),
              child: Transform.rotate(
                angle: 135 * pi / 180,
                child: SizedBox(
                  width: ringSize,
                  height: ringSize,
                  child: CircularProgressIndicator(
                    value: controller.value,
                    color: darkTheme.accentColor,
                    strokeWidth: 20,
                  ),
                ),
              )
            ),
            const Center(
              child: Text("Ring",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontFamily: "TalkComic",
                    fontWeight: FontWeight.bold)),
            )
          ],
        ),
      )

    );
  }
}