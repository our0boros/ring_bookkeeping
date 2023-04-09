import 'package:flutter/material.dart';
import 'package:ring_bookkeeping/theme.dart';

import 'package:ring_bookkeeping/data/node.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Node> _monthList = [
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
    Node(
        title: "",
        tag: "银行取款",
        amount: 3000,
        date: DateTime.now(),
        currency: "CNY"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double recordWidth = MediaQuery.of(context).size.width * 0.75;

    return Container(
      color: darkTheme.backgroundColor,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: darkTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          border: new Border.all(width: 1, color: Colors.red),
        ),
        child: ListView.builder(
            itemCount: _monthList.length,
            itemBuilder: (BuildContext context, int index) {
              return transactionRecord(_monthList[index], recordWidth);
            }),
      ),
    );
  }
}