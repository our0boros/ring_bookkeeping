import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static DBHelper get instance => _instance;
  static Database? _database;

  DBHelper._internal();

  Future<Database?> getDatabase() async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

//  初始化db
  Future<Database> _initDatabase() async {
    final path = join(getDatabasesPath() as String, 'bill.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE bills (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            tag TEXT,
            amount REAL,
            date TEXT,
            currency TEXT
          )
        ''');
    });
  }




}
