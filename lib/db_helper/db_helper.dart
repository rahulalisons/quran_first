import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "quran_db.sqlite");

    // Copy from assets if not exists
    if (!await File(path).exists()) {
      ByteData data = await rootBundle.load('assets/app/db/quran_db.sqlite');
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path);
  }
  //
  // Future<List<Map<String, dynamic>>> getVersesBySura(int suraNumber) async {
  //   final db = await database;
  //   return await db.query('verses', where: 'sura = ?', whereArgs: [suraNumber]);
  // }

  Future<List<Map<String, dynamic>>> getAllChapters() async {
    final db = await database;
    return await db.query('ma_surath');
  }
}
