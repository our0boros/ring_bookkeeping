import 'package:flutter/material.dart';
import 'package:ring_bookkeeping/theme.dart';

import 'package:ring_bookkeeping/items/custom_row.dart';
import 'package:ring_bookkeeping/items/expandable_row.dart';
class Node {
  // id INTEGER PRIMARY KEY AUTOINCREMENT,
  // title TEXT,
  // tag TEXT,
  // amount REAL,
  // date TEXT,
  // currency TEXT

  // final int id;
  final String title;
  final String tag;
  final double amount;
  final DateTime date;
  final String currency;

  Node({
    // required this.id,
    required this.title,
    required this.tag,
    required this.amount,
    required this.date,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'title': title,
      'tag': tag,
      'amount': amount,
      'date': date.toIso8601String(),
      'currency': currency,
    };
  }

  static Node fromMap(Map<String, dynamic> map) {
    return Node(
      // id: map['id'],
      title: map['title'],
      tag: map['tag'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      currency: map['currency'],
    );
  }
}

Widget transactionRecord(Node node, double width) {
  return Container(
    padding: EdgeInsets.all(5),
    width: width,
    height: 50,
    color: darkTheme.primaryColor,
    child:
    // ExpandableRow()

    CustomRow(
      leftIcon: Icons.currency_bitcoin,
      rightIcon: Icons.wifi_tethering,
      number: node.amount.toInt(),
    )

    // Row(
    //   // scrollDirection: Axis.horizontal,
    //   children: [
    //     Icon(
    //       Icons.access_alarm_rounded,
    //       color: darkTheme.invertTextColor,
    //       size: 45,
    //     ),  // tag
    //
    //     SizedBox(
    //       width: 100,
    //       child: Center(child: Text(node.title)),
    //     ),
    //     Center(child: Text(
    //       node.amount.toString(),
    //       style: TextStyle(
    //         color: darkTheme.invertTextColor,
    //         fontSize: 30,
    //         fontFamily: "BruceForeverRegular",
    //         fontWeight: FontWeight.w800,
    //
    //       ),
    //
    //
    //     )),
    //     Icon(
    //       Icons.currency_bitcoin,
    //       color: darkTheme.invertTextColor,
    //       size: 45,
    //     ), // currency
    //     // Text(node.date.toString())
    //   ],
    // ),
  );
}
