import 'package:flutter/material.dart';
import 'package:ring_bookkeeping/data/init_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';

import 'package:ring_bookkeeping/appThemes.dart';
import 'package:ring_bookkeeping/data/node.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Node> _entryList;

  bool isDarkMode = true;
  final DBHelper _dbHelper = DBHelper();
  late Database _database;

  @override
  Future<void> initState() async {
    super.initState();
    getPrefsSettings();
    _entryList = await _dbHelper.query();
    debugPrint("[HOME] current entry list length: ${_entryList.length}");
  }


  void getPrefsSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isDarkMode") == null) {
      prefs.setBool("isDarkMode", false);
    }

    setState(() {
      isDarkMode = prefs.getBool("isDarkMode")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double recordWidth = MediaQuery.of(context).size.width * 0.75;
    final double screenHeight = MediaQuery.of(context).size.height * 0.26;
    /// 每次刷新都更新一次资料库，可能会造成卡顿，测试使用
    // setState(() {
    //   _dbHelper.query().then((value) => _entryList = value);
    // });

    return Material(
      color: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: screenHeight,
            decoration: BoxDecoration(
              color: isDarkMode ? darkTheme.subBackgroundColor : lightTheme.subBackgroundColor,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 8)
                ),
              ]
            ),
          ),
          Container(
            color: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
            child: ListView.builder(
              itemCount: _entryList.length,
              itemBuilder: (BuildContext context, int index) {
                if (_entryList.isEmpty) {
                  return Placeholder();
                } else {
                  return SizedBox(
                    height: 300,
                    child: ListView(
                      children: [
                        Text(_entryList[index].title),
                        Text(_entryList[index].currency),
                        Text(_entryList[index].tag),
                        Text(_entryList[index].amount.toString()),
                        Text(_entryList[index].date.toString()),
                      ],
                    ),
                  );
                }
              }
            ),
          )
        ],
      ),
    );
  }
}