import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/JuzSurahItem.dart';

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

  Future<List<Map<String, dynamic>>> getAllEnSurah({String? code}) async {
    final db = await database;
    return await db.query('${code}_surath');
  }

  // Future<List<Map<String, dynamic>>> getAllAyath({String? code}) async {
  //   final db = await database;
  //   return await db.query('${code}_ayath');
  // }

  Future<List<Map<String, dynamic>>> getSurahAyahCounts({String? code}) async {
    final db = await database;
    return await db.rawQuery('''
    SELECT surath_no, COUNT(*) as ayah_count
    FROM ar_ayath
    GROUP BY surath_no
    ORDER BY surath_no
  ''');
  }

  Future<List<Map<String, dynamic>>> getAllJuz() async {
    final db = await database;
    return await db.query('juzh');
  }

  Future<List<JuzSurahItem>?> fetchJuzSurahData() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
 SELECT 
    j.juzh_no,
    j.surath_no,
    s.surah_name,  -- fetch from a separate table if necessary
    MIN(j.ayath_no) AS start_verse,
    MAX(j.ayath_no) AS end_verse
FROM 
    juzh j
JOIN 
    surah_table s  -- join with a separate surah table for names
ON 
    j.surath_no = s.surath_no
GROUP BY 
    j.juzh_no, j.surath_no, s.surah_name
ORDER BY 
    j.juzh_no, j.surath_no, start_verse;
    ''');

    // Process data into grouped format (Group by Juz number)
    Map<int, List<SurahInfo>> groupedData = {};

    for (var row in result) {
      int juzNumber = row['juzh_no'];
      final surah = SurahInfo(
        surahNumber: row['surath_no'],
        surahName: row['surath_name'],
        startVerse: row['start_verse'],
        endVerse: row['end_verse'],
      );

      if (!groupedData.containsKey(juzNumber)) {
        groupedData[juzNumber] = [];
      }
      groupedData[juzNumber]!.add(surah);
    }

    List<JuzSurahItem> tempList = groupedData.entries.map((entry) {
      return JuzSurahItem(juzNumber: entry.key, surahs: entry.value);
    }).toList();

    return tempList;
  }



  Future<List<Map<String, dynamic>>> getAyathsBySurah({int? surahNo,String?code}) async {
    final db = await database;
    return await db.query(
      '${code}_ayath',
      where: 'surath_no = ?',
      whereArgs: [surahNo],
    );
  }
}
