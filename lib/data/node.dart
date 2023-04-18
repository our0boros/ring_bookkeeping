import 'package:flutter/material.dart';
import 'package:ring_bookkeeping/appThemes.dart';

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

  static Node fromMap(Map<dynamic, dynamic> map) {
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
