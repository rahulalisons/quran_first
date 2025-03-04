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




  Future<List<Map<String, dynamic>>> getAyathsBySurah({int? surahNo,String?code}) async {
    final db = await database;
    return await db.query(
      '${code}_ayath',
      where: 'surath_no = ?',
      whereArgs: [surahNo],
    );
  }

  Future<List<JuzhData>> fetchJuzhData() async {
    final db = await database;
    final result = await db.rawQuery('''
    WITH AyahRanks AS (
        SELECT
            j.juzh_no,
            j.surath_no,
            j.ayath_no,
            ROW_NUMBER() OVER (PARTITION BY j.surath_no ORDER BY j.ayath_no) AS ayah_rank
        FROM
            juzh j
    )
    SELECT
        ar.juzh_no,
        ar.surath_no,
        s.surath_name,
        MIN(ar.ayah_rank) AS start_ayah,
        MAX(ar.ayah_rank) AS end_ayah,
        COUNT(*) AS verse_count
    FROM
        AyahRanks ar
    JOIN
        en_surath s ON ar.surath_no = s.surath_no
    GROUP BY
        ar.juzh_no, ar.surath_no
    ORDER BY
        ar.juzh_no, ar.surath_no;
  ''');

    Map<int, List<SurahData>> juzhMap = {};

    for (final row in result) {
      final juzhNo = row['juzh_no'] as int;
      final surahData = SurahData(
        surahName: row['surath_name'] as String,
        startAyah: row['start_ayah'] as int,
        endAyah: row['end_ayah'] as int,
        verseCount: row['verse_count'] as int,
      );

      juzhMap.putIfAbsent(juzhNo, () => []);
      juzhMap[juzhNo]!.add(surahData);
    }

    return juzhMap.entries.map((entry) {
      return JuzhData(juzhNo: entry.key, surahs: entry.value);
    }).toList();
  }




}
