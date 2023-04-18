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

  @override
  void initState() {
    super.initState();
    getPrefsSettings();

    Future.delayed(Duration.zero, () async {
      _entryList = await _dbHelper.query();
      // _dbHelper.insert(Node(title: "CASH", tag: "CASH", amount: 320, date: DateTime.now(), currency: "CNY"));
      debugPrint("[HOME] current entry list length: ${_entryList.length}");
    });
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
          Container(
            height: screenHeight * 0.74,
            color: isDarkMode ? darkTheme.backgroundColor : lightTheme.backgroundColor,
            child: FutureBuilder<List<Node>> (
              future: _dbHelper.query(),
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        debugPrint("[HOME] ===================[ $index ]================");
                        debugPrint("[HOME] node-tile ${data?[index].title}");
                        debugPrint("[HOME] node-currency ${data?[index].currency}");
                        debugPrint("[HOME] node-tag ${data?[index].tag}");
                        debugPrint("[HOME] node-amount ${data?[index].amount.toString()}");
                        debugPrint("[HOME] node-date ${data?[index].date.toString()}");
                        return Container(
                          width: screenWidth * 0.75,
                          height: 50,
                          // color: Colors.black,
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data![index].title),
                              Text(data[index].currency),
                              Text(data[index].tag),
                              Text(data[index].amount.toString()),
                              Text(data[index].date.toString()),
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
                      child: CircularProgressIndicator(
                        color: isDarkMode ? darkTheme.mainTextColor : lightTheme.mainTextColor,
                        strokeWidth: 30,
                      ),),);
                }
              },
            )



          )
        ],
      ),
    );
  }
}