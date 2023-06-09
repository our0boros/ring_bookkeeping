import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

import 'node.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  Database? _database;

  DBHelper._internal();

  factory DBHelper() {
    return _instance;
  }
  /// ===============================================
  /// 创建数据库、回传数据库
  /// ===============================================
  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    debugPrint("[DBHepler] waiting for db");
    return _database ??= await openDatabase(
      join(dbPath, 'bills.db'),
      onCreate: (db, version) {
        debugPrint("[DBHepler] init new databse");
        return db.execute('''
          CREATE TABLE bills (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            tag TEXT,
            amount REAL,
            date TEXT,
            currency TEXT
          )
        '''
        );
      },
      version: 1,
    );
  }

  /// ===============================================
  /// 插入数据
  /// ===============================================
  Future insert(Node entry) async {
    final db = await initDatabase();

    await db.insert(
      'bills',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// ===============================================
  /// 获取数据
  /// ===============================================
  Future<List<Node>> query() async {
    final db = await initDatabase();
    final List<Map> maps = await db.rawQuery('SELECT * FROM bills ORDER BY id DESC;');

    var data = List.generate(maps.length, (i) {
      // debugPrint(maps[i].values.toString());
      return Node.fromMap(maps[i]);
    });
    debugPrint("[DBHepler] found ${data.length} data \n $data");
    return List.from(data);
  }

  /// ===============================================
  /// 获取数据
  /// 要求 SELECT * FROM bills
  /// ===============================================
  Future<List<Node>> querySpec({int year = -1, int month = -1, int date = -1}) async {
    String yearStr = year.toString().padLeft(4, '0');
    String monthStr = month.toString().padLeft(2, '0');
    String dateStr = date.toString().padLeft(2, '0');

    final db = await initDatabase();
    String raw = 'SELECT * FROM bills WHERE date LIKE "'
        '${yearStr == "00-1" ? "%" : yearStr}-'
        '${monthStr == "-1" ? "%" : monthStr}-'
        '${dateStr == "-1" ? "%" : dateStr}T%" '
        'ORDER BY date DESC;';
    final List<Map> maps = await db.rawQuery(raw);
    debugPrint('[DBHelper use QUERY: $raw');

    var data = List.generate(maps.length, (i) {
      return Node.fromMap(maps[i]);
    });
    debugPrint("[DBHepler] found ${data.length} data \n $data");
    return List.from(data);
  }

  /// ===============================================
  /// 删除数据
  /// ===============================================
  Future<int> delete(String mid) async {
    final db = await initDatabase();
    return await db.rawDelete('DELETE FROM chat WHERE mid = ?', [mid]);
  }

  /// ===============================================
  /// 关闭数据库
  /// ===============================================
  Future<void> close() async {
    final db = await initDatabase();
    await db.close();
  }

}
