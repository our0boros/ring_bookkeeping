import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

//主题
import 'package:ring_bookkeeping/appThemes.dart';

//页面
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
  // 主题模式
  bool isDarkMode = true;
  bool disableFAB = false;

  // 导航栏
  late PageController pageController;

  final List<Widget> _children = const [
    HomePage(),
    DataAnalysis(),
    Settings(),
  ];

  void getPrefsSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isDarkMode") == null) {
      prefs.setBool("isDarkMode", false);
    }
    if (prefs.getBool("disableFAB") == null) {
      prefs.setBool("disableFAB", false);
    }

    setState(() {
      isDarkMode = prefs.getBool("isDarkMode")!;
      disableFAB = prefs.getBool("disableFAB")!;
    });
  }

  @override
  void initState() {
    super.initState();
    // 获取主题
    getPrefsSettings();
    // 获取pageview controller
    pageController = PageController(
      initialPage: 0,
      // 所有页面保持激活
      keepPage: true,
    );

    pageController.addListener(() {
      //PageView滑动的距离
      double offset = pageController.offset;
      // debugPrint("[NAV] pageView scroll distance $offset");
    });
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalObjectKey<ExpandableFabState>(context);
    return Scaffold(
      body: PageView(
        onPageChanged: (int index) {
          debugPrint("[NAV] current $index");
          setState(() {});
        },
        reverse: false,
        physics: const ClampingScrollPhysics(),
        // BouncingScrollPhysics() 回弹
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: _children,
      ),

      /// ===============================================
      /// 浮标导航栏按钮
      /// ===============================================
      floatingActionButtonLocation: disableFAB ? null : ExpandableFab.location,
      floatingActionButton: _getFAB(key, disableFAB),
    );
  }

  Widget _getFAB(key, disableFAB) {
    if (disableFAB) {
      return Container();
    }
    return ExpandableFab(
      key: key,
      // duration: const Duration(seconds: 1),
      // distance: 60.0,
      type: ExpandableFabType.fan,
      // fanAngle: 70,
      child: const Icon(Icons.list_outlined),
      foregroundColor:
          isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor,
      backgroundColor:
          isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
      closeButtonStyle: ExpandableFabCloseButtonStyle(
        child: const Icon(Icons.close),
        foregroundColor:
            isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor,
        backgroundColor:
            isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
      ),

      overlayStyle: ExpandableFabOverlayStyle(
        // color: Colors.black.withOpacity(0.5),
        blur: 5,
      ),
      onOpen: () {
        debugPrint('[NAV] onOpen');
      },
      afterOpen: () {
        debugPrint('[NAV] afterOpen');
      },
      onClose: () {
        debugPrint('[NAV] onClose');
      },
      afterClose: () {
        debugPrint('[NAV] afterClose');
      },
      children: [
        FloatingActionButton.small(
          heroTag: null,
          foregroundColor:
              isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor,
          backgroundColor: isDarkMode
              ? darkTheme.backgroundColor
              : lightTheme.backgroundColor,
          child: const Icon(Icons.edit),
          onPressed: () {
            pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );

            // 关闭tab
            final state = key.currentState;
            if (state != null) {
              debugPrint('[NAV] isOpen:${state.isOpen}');
              state.toggle();
            }
          },
        ),
        FloatingActionButton.small(
          heroTag: null,
          foregroundColor:
              isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor,
          backgroundColor: isDarkMode
              ? darkTheme.backgroundColor
              : lightTheme.backgroundColor,
          child: const Icon(Icons.search),
          onPressed: () {
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );

            // 关闭tab
            final state = key.currentState;
            if (state != null) {
              debugPrint('[NAV] isOpen:${state.isOpen}');
              state.toggle();
            }
          },
        ),
        FloatingActionButton.small(
            heroTag: null,
            foregroundColor:
                isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor,
            backgroundColor: isDarkMode
                ? darkTheme.backgroundColor
                : lightTheme.backgroundColor,
            child: const Icon(Icons.share),
            onPressed: () {
              pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );

              // 关闭tab
              final state = key.currentState;
              if (state != null) {
                debugPrint('[NAV] isOpen:${state.isOpen}');
                state.toggle();
              }
            }),
      ],
    );
  }
}
