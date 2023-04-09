import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ring_bookkeeping/theme.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

import 'package:ring_bookkeeping/pages/home_page.dart';
import 'package:ring_bookkeeping/pages/settings_page.dart';
import 'package:ring_bookkeeping/pages/analysis_page.dart';


class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;
  DateTime? lastPopTime;

  final List<Widget> _children = const [
    HomePage(),
    Settings(),
    DataAnalysis(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _children,
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: darkTheme.backgroundColor,
            items: const <Widget> [
              Icon(Icons.note_add_rounded, size: 30),
              Icon(Icons.settings, size: 30),
              Icon(Icons.analytics, size: 30),
            ],
            onTap: (index) {
              onTabTapped(index);
              //Handle button tap
            },
          )

          // BottomNavigationBar(
          //   currentIndex: _currentIndex,
          //   onTap: onTabTapped,
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.note_add_rounded),
          //       label: '',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.settings),
          //       label: '',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.analytics),
          //       label: '',
          //     ),
          //   ],
          // ),
        ),

        onWillPop: () async {
          if (lastPopTime == null || DateTime.now().difference(lastPopTime!) > const Duration(seconds: 1)) {
            lastPopTime = DateTime.now();
            // 这里没有弹出Toast 不知道为什么
            Toast.show(
                "再按一次退出",
                duration: Toast.lengthShort,
                gravity: Toast.bottom);
            return Future.value(false);
          } else {
            lastPopTime = DateTime.now();
            return Future.value(true);
          }});
  }
}
