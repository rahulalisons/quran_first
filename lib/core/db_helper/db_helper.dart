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

  Future<List<Map<String, dynamic>>> randomAyath() async {
    final db = await database;
    return await db.rawQuery(''' 
  SELECT 
      ar_ayath.surath_no AS surah_no,
      ar_ayath.ayath_no AS ayath_no,
      ar_ayath.ayath AS ar_ayath_text,
      en_ayath.ayath AS en_ayath_text,
      en_surath.surath_name AS surah_name
  FROM 
      ar_ayath
  JOIN en_ayath 
      ON ar_ayath.surath_no = en_ayath.surath_no 
      AND ar_ayath.ayath_no = en_ayath.ayath_no
  JOIN en_surath 
      ON ar_ayath.surath_no = en_surath.surath_no
  WHERE 
      LENGTH(ar_ayath.ayath) < 150  -- Ensure Arabic Ayah text is less than 100 characters
      AND LENGTH(en_ayath.ayath) < 150  -- Ensure English translation is also less than 100 characters
  ORDER BY RANDOM()
  LIMIT 1;
  ''');
  }

  Future<List<Map<String, dynamic>>> getAllSurah({String? searchQuery}) async {
    final db = await database;

    if (searchQuery != null && searchQuery.isNotEmpty) {
      return await db.rawQuery('''
      SELECT ar_surath.surath_no, 
             ar_surath.surath_name AS ar_surath_name, 
             en_surath.surath_name AS en_surath_name, 
             COUNT(ar_ayath.ayath_no) AS ayath_count
      FROM ar_surath
      JOIN en_surath ON ar_surath.surath_no = en_surath.surath_no
      JOIN ar_ayath ON ar_surath.surath_no = ar_ayath.surath_no
      WHERE ar_surath.surath_name LIKE ? OR en_surath.surath_name LIKE ?
      GROUP BY ar_surath.surath_no
      ORDER BY ar_surath.surath_no;
    ''', ['%$searchQuery%', '%$searchQuery%']); // Uses LIKE for partial match
    } else {
      return await db.rawQuery('''
      SELECT ar_surath.surath_no, 
             ar_surath.surath_name AS ar_surath_name, 
             en_surath.surath_name AS en_surath_name, 
             COUNT(ar_ayath.ayath_no) AS ayath_count
      FROM ar_surath
      JOIN en_surath ON ar_surath.surath_no = en_surath.surath_no
      JOIN ar_ayath ON ar_surath.surath_no = ar_ayath.surath_no
      GROUP BY ar_surath.surath_no
      ORDER BY ar_surath.surath_no;
    ''');
    }
  }





  Future<List<Map<String, dynamic>>> getAllEnSurah({String? code}) async {
    final db = await database;
    return await db.query('${code}_surath');
  }

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

  Future<List<Map<String, dynamic>>> getAyathsBySurah(
      {int? surahNo, String? code}) async {
    final db = await database;
    return await db.query(
      '${code}_ayath',
      where: 'surath_no = ?',
      whereArgs: [surahNo],
    );
  }

  // Future<List<JuzhData>> fetchJuzhData() async {
  //   final db = await database;
  //   final result = await db.rawQuery('''
  //   WITH AyahRanks AS (
  //       SELECT
  //           j.juzh_no,
  //           j.surath_no,
  //           j.ayath_no,
  //           ROW_NUMBER() OVER (PARTITION BY j.surath_no ORDER BY j.ayath_no) AS ayah_rank
  //       FROM
  //           juzh j
  //   )
  //   SELECT
  //       ar.juzh_no,
  //       ar.surath_no,
  //       s.surath_name,
  //       MIN(ar.ayah_rank) AS start_ayah,
  //       MAX(ar.ayah_rank) AS end_ayah,
  //       COUNT(*) AS verse_count
  //   FROM
  //       AyahRanks ar
  //   JOIN
  //       en_surath s ON ar.surath_no = s.surath_no
  //   GROUP BY
  //       ar.juzh_no, ar.surath_no
  //   ORDER BY
  //       ar.juzh_no, ar.surath_no;
  // ''');
  //
  //   Map<int, List<SurahData>> juzhMap = {};
  //
  //   for (final row in result) {
  //     final juzhNo = row['juzh_no'] as int;
  //     final surahData = SurahData(
  //       surahName: row['surath_name'] as String,
  //       startAyah: row['start_ayah'] as int,
  //       endAyah: row['end_ayah'] as int,
  //       verseCount: row['verse_count'] as int,
  //     );
  //
  //     juzhMap.putIfAbsent(juzhNo, () => []);
  //     juzhMap[juzhNo]!.add(surahData);
  //   }
  //
  //   return juzhMap.entries.map((entry) {
  //     return JuzhData(juzhNo: entry.key, surahs: entry.value);
  //   }).toList();
  // }
}
