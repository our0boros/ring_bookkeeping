// 基础套件
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 数据共享
import 'package:shared_preferences/shared_preferences.dart';
// 样式
import 'package:ring_bookkeeping/items/NeumorphicButton.dart';
import 'package:ring_bookkeeping/items/NeumorphicSwitch.dart';

import 'package:ring_bookkeeping/appThemes.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // 主题模式
  bool isDarkMode = true;
  bool disableFAB = false;
  bool useEN = true;
  bool skipSplash = true;
  bool exitApp = false;

  void getPrefsSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isDarkMode") == null) {
      prefs.setBool("isDarkMode", false);
    }
    if (prefs.getBool("disableFAB") == null) {
      prefs.setBool("disableFAB", false);
    }
    if (prefs.getBool("useEN") == null) {
      prefs.setBool("useEN", true);
    }
    if (prefs.getBool("skipSplash") == null) {
      prefs.setBool("skipSplash", true);
    }

    setState(() {
      isDarkMode = prefs.getBool("isDarkMode")!;
      disableFAB = prefs.getBool("disableFAB")!;
      useEN = prefs.getBool("useEN")!;
      skipSplash = prefs.getBool("skipSplash")!;
    });
  }

  @override
  void initState() {
    super.initState();
    // 获取主题
    getPrefsSettings();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
      child: ListView(
        children: [
          const Divider(color: Color(0x00000000), thickness: 0, height: 20,),

          switchRow(
            useEN ? "DARK MODE" : "黑暗模式",
            isDarkMode,
                (bool value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                isDarkMode = value;
                prefs.setBool("isDarkMode", value);
                debugPrint("[SETTINGS] change to dark mode");
              });
            },
          ),

          const Divider(color: Color(0x00000000), thickness: 0, height: 20,),

          switchRow(
            useEN ? "Disable Nav Bottom" : "禁用导航按钮",
            disableFAB,
                (bool value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                disableFAB = value;
                prefs.setBool("disableFAB", value);
              });
            },
          ),

          const Divider(color: Color(0x00000000), thickness: 0, height: 20,),

          switchRow(
            useEN ? "English" : "中文",
            useEN,
            (bool value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                useEN = value;
                prefs.setBool("useEN", value);
              });
            },
          ),

          const Divider(color: Color(0x00000000), thickness: 0, height: 20,),

          switchRow(
            useEN ? "Skip splash page" : "跳过启动界面",
            skipSplash,
                (bool value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                skipSplash = value;
                prefs.setBool("skipSplash", value);
              });
            },
          ),

          NeumorphicButton(
            value: exitApp,
            buttonColor: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
            lightShadowColor: isDarkMode ? Color(0x0aF6F6F6) : Color(0x3affffff),
            darkShadowColor: isDarkMode ? Color(0x3a000000) : Color(0x3a282828),
            child: Text(
                useEN ? "EXIT" : "退出应用",
              style: TextStyle(
                color: isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor
              ),
            ),
            // buttonColor: Colors.redAccent,
            onChanged: ((value) {
              // debugPrint("[SETTINGS] set reboot button to $value");
              // if (Platform.isAndroid) {
              //   SystemNavigator.pop();
              // } else if (Platform.isIOS) {
              //   exit(0);
              // }
            }),

          ),

        ],
      ),
    );
  }

  Widget switchRow(String text, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Text(text),
        ),
        Container(
          margin: EdgeInsets.only(right: 30),
          child: NeumorphicSwitch(
            value: value,
            onChanged: onChanged,
            selectColor: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
          ),
        )
      ],
    );
  }

}
