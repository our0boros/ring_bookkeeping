import 'package:flutter/material.dart';
import 'package:ring_bookkeeping/data/init_database.dart';
import 'package:ring_bookkeeping/items/dateEntryRow.dart';
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

  // 数据表
  final DBHelper _dbHelper = DBHelper();
  // 时间
  late int year;
  late int month;

  bool isDarkMode = true;


  @override
  void initState() {
    super.initState();
    // 获取初始设定
    getPrefsSettings();

    year = DateTime.now().year;
    month = DateTime.now().month;

    // 获取数据库数据
    // Future.delayed(Duration.zero, () async {
    //   _entryList = await _dbHelper.query();
    //   _dbHelper.insert(Node(title: "WOW", tag: "GAME", amount: -1240, date: DateTime(2023, 3, 26, 22, 00, 12, 3), currency: "USD"));
    //   debugPrint("[HOME] current entry list length: ${_entryList.length}");
    // });
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Positioned(
            top: screenHeight * 0.26,
            left: 0,
            child: Container(
                height: screenHeight * 0.74,
                width: screenWidth,
                color: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
                child: FutureBuilder<List<Node>> (
                  future: _dbHelper.querySpec(year: year, month: month),
                  // future: _dbHelper.querySpec(),
                  builder: (context, snapshot) {
                    /// 用于测试加载界面
                    // return Center(
                    //   child: SizedBox(
                    //     width: screenWidth * 0.25,
                    //     height: screenWidth * 0.25,
                    //     child: RefreshProgressIndicator(
                    //       backgroundColor: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
                    //       color: isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor,
                    //       strokeWidth: 10,
                    //     ),),);

                    if (snapshot.hasData) {
                      final snapData = snapshot.data;
                      int daysInMonth = DateTime(year, month, 0).day;
                      List<List<Node>> data = List.generate(daysInMonth, (index) => []);
                      // 分类同一天的数据
                      debugPrint("[HOME] [FutureBuilder] ============= START SORTING DATA =============");
                      for (var node in snapData!) {
                        // 获取当前日期
                        int nodeDate = int.parse(node.date.toString().substring(8, 10));
                        debugPrint("[HOME] [FutureBuilder] current node date: $nodeDate");
                        data[nodeDate - 1].add(node);
                      }
                      debugPrint("[HOME] [FutureBuilder] sorted data: $data");
                      debugPrint("[HOME] [FutureBuilder] ============= DONE =============");

                      return ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          // physics: const ClampingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            debugPrint("[HOME] [FutureBuilder] [Listview] ===================[ ${index + 1} ]================");
                            debugPrint("[HOME] [FutureBuilder] [Listview] current date has ${data[index].length} entry/entries");

                            // 如果当天存在一次交易
                            if (data[index].isNotEmpty) {
                              debugPrint(data[index].length.toString());
                              return dateEntryRow(entries: data[index], width: screenWidth * 0.85);
                            } else {
                              return Container();
                            }
                          }
                      );

                      /// 未经整理直接显示
                      /// 已弃用
                      return ListView.builder(
                          itemCount: snapData.length,
                          itemBuilder: (BuildContext context, int index) {
                            debugPrint("[HOME] ===================[ $index ]================");
                            debugPrint("[HOME] node-tile ${snapData[index].title}");
                            debugPrint("[HOME] node-currency ${snapData[index].currency}");
                            debugPrint("[HOME] node-tag ${snapData[index].tag}");
                            debugPrint("[HOME] node-amount ${snapData[index].amount.toString()}");
                            debugPrint("[HOME] node-date ${snapData[index].date.toString()}");
                            return Container(
                              width: screenWidth * 0.75,
                              height: 50,
                              // color: Colors.black,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(snapData[index].title),
                                  Text(snapData[index].currency),
                                  Text(snapData[index].tag),
                                  Text(snapData[index].amount.toString()),
                                  Text(snapData[index].date.toString()),
                                ],
                              ),

                            );

                          }
                      );

                    } else {
                      return Center(
                        child: SizedBox(
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          child: RefreshProgressIndicator(
                                backgroundColor: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
                                color: isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor,
                                strokeWidth: 10,
                              ),),);
                    }
                  },
                )
            ),
          ),
          Container(
            height: screenHeight * 0.26,
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
        ],
      ),
    );
  }
}