import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/bookmark_model.dart';
import '../../models/translator_model.dart';

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
        en_ayath.translator_id = 1  -- Filter English translation by translator ID
        AND LENGTH(ar_ayath.ayath) < 150  -- Ensure Arabic Ayah text is less than 150 characters
        AND LENGTH(en_ayath.ayath) < 150  -- Ensure English translation is also less than 150 characters
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

  // Future<List<Map<String, dynamic>>> getSurahDetails(int surahNo,
  //     {String? key}) async {
  //   final db = await database;
  //   return await db.rawQuery('''
  // SELECT
  //     ar_surath.surath_no,
  //     ar_surath.surath_name AS arabic_surath_name,
  //     en_surath.surath_name AS english_surath_name,
  //     (SELECT COUNT(*) FROM ar_ayath WHERE ar_ayath.surath_no = ar_surath.surath_no) AS ayath_count,
  //     ar_ayath.ayath_no,
  //     ar_ayath.ayath AS arabic_ayath,
  //
  //     en_ayath_3.ayath AS english_ayath_translator_3,
  //
  //     CASE
  //         WHEN ? = 'english' THEN en_ayath_1.ayath
  //         ELSE NULL
  //     END AS english_ayath_translator_1,
  //
  //     CASE
  //         WHEN ? = 'malayalam' THEN ma_ayath_1.ayath
  //         ELSE NULL
  //     END AS malayalam_ayath_translator_1,
  //
  //     -- Check if the ayath exists in the bookmark table and return true/false
  //     CASE
  //         WHEN EXISTS (
  //             SELECT 1 FROM bookmark
  //             WHERE bookmark.surath_no = ar_ayath.surath_no
  //             AND bookmark.ayath_no = ar_ayath.ayath_no
  //         ) THEN 'true'
  //         ELSE 'false'
  //     END AS is_bookmarked
  //
  // FROM ar_surath
  // JOIN en_surath ON ar_surath.surath_no = en_surath.surath_no
  // JOIN ar_ayath ON ar_surath.surath_no = ar_ayath.surath_no
  // LEFT JOIN en_ayath AS en_ayath_3
  //     ON ar_ayath.surath_no = en_ayath_3.surath_no
  //     AND ar_ayath.ayath_no = en_ayath_3.ayath_no
  //     AND en_ayath_3.translator_id = 3
  // LEFT JOIN en_ayath AS en_ayath_1
  //     ON ar_ayath.surath_no = en_ayath_1.surath_no
  //     AND ar_ayath.ayath_no = en_ayath_1.ayath_no
  //     AND en_ayath_1.translator_id = 1
  // LEFT JOIN ma_ayath AS ma_ayath_1
  //     ON ar_ayath.surath_no = ma_ayath_1.surath_no
  //     AND ar_ayath.ayath_no = ma_ayath_1.ayath_no
  //     AND ma_ayath_1.translator_id = 1
  // WHERE ar_surath.surath_no = ?
  // ORDER BY ar_ayath.ayath_no;
  // ''', [key, key, surahNo]);
  // }

  Future<List<Map<String, dynamic>>> getSurahDetails(int surahNo,
      {String? key, int? translatorId}) async {
    final db = await database;
    print('key iss---$key-----id is----$translatorId');

    key ??= 'english';
    translatorId ??= 1;

    return await db.rawQuery('''
  SELECT 
      ar_surath.surath_no,
      ar_surath.surath_name AS arabic_surath_name,
      en_surath.surath_name AS english_surath_name,
      (SELECT COUNT(*) FROM ar_ayath WHERE ar_ayath.surath_no = ar_surath.surath_no) AS ayath_count,
      ar_ayath.ayath_no,
      ar_ayath.ayath AS arabic_ayath,

      -- Static English Translator 3 (Does not change based on key)
      en_ayath_3.ayath AS english_ayath_translator_3,

      -- Dynamically fetch based on key and translatorId
      CASE 
          WHEN ? = 'english' THEN 
              (SELECT ayath FROM en_ayath 
               WHERE en_ayath.surath_no = ar_ayath.surath_no 
               AND en_ayath.ayath_no = ar_ayath.ayath_no 
               AND en_ayath.translator_id = ?)
          ELSE NULL 
      END AS english_ayath_translator_1,

      CASE 
          WHEN ? = 'malayalam' THEN 
              (SELECT ayath FROM ma_ayath 
               WHERE ma_ayath.surath_no = ar_ayath.surath_no 
               AND ma_ayath.ayath_no = ar_ayath.ayath_no 
               AND ma_ayath.translator_id = ?)
          ELSE NULL 
      END AS malayalam_ayath_translator_1,

      -- Check if the ayath exists in the bookmark table and return true/false
      CASE 
          WHEN EXISTS (
              SELECT 1 FROM bookmark 
              WHERE bookmark.surath_no = ar_ayath.surath_no 
              AND bookmark.ayath_no = ar_ayath.ayath_no
          ) THEN 'true'
          ELSE 'false'
      END AS is_bookmarked

  FROM ar_surath
  JOIN en_surath ON ar_surath.surath_no = en_surath.surath_no
  JOIN ar_ayath ON ar_surath.surath_no = ar_ayath.surath_no

  -- Keep translator 3 query separate (remains unchanged)
  LEFT JOIN en_ayath AS en_ayath_3 
      ON ar_ayath.surath_no = en_ayath_3.surath_no 
      AND ar_ayath.ayath_no = en_ayath_3.ayath_no 
      AND en_ayath_3.translator_id = 3

  WHERE ar_surath.surath_no = ?
  ORDER BY ar_ayath.ayath_no;
  ''', [key, translatorId, key, translatorId, surahNo]);
  }

  Future<bool> addBookmark(
      {int? surahNo, int? ayathNo, String? ayath, String? translation}) async {
    final db = await database;
    int rowsAffected = await db.rawInsert(
        'INSERT INTO bookmark (surath_no, ayath_no, ayath, translation) VALUES (?, ?, ?, ?);',
        [surahNo, ayathNo, ayath, translation]);
    return rowsAffected > 0;
  }

  Future<bool> removeBookmark({int? surahNo, int? ayathNo}) async {
    final db = await database; // Get database instance

    int rowsAffected = await db.delete(
      'bookmark',
      where: 'surath_no = ? AND ayath_no = ?',
      whereArgs: [surahNo, ayathNo],
    );

    return rowsAffected > 0;
  }

  Future<void> clearBookmarks() async {
    final db = await database;
    await db.rawDelete('DELETE FROM bookmark;');
  }

  //  test
  Future<List<SurahBookmarks>> getBookmark() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
        b.surath_no, 
        s.surath_name, 
        b.ayath_no,
        (SELECT COUNT(*) FROM bookmark WHERE surath_no = b.surath_no) AS bookmark_count, 
        b.ayath, 
        e1.ayath AS en_ayath_t1, 
        e3.ayath AS en_ayath_t3,
        1 AS isBookmarked  
    FROM bookmark b
    JOIN ar_surath s ON b.surath_no = s.surath_no
    LEFT JOIN en_ayath e1 ON b.surath_no = e1.surath_no 
                          AND b.ayath_no = e1.ayath_no 
                          AND e1.translator_id = 1
    LEFT JOIN en_ayath e3 ON b.surath_no = e3.surath_no 
                          AND b.ayath_no = e3.ayath_no 
                          AND e3.translator_id = 3;
  ''');

    // Group by Surah
    Map<int, SurahBookmarks> surahMap = {};

    for (var row in result) {
      int surahNo = row['surath_no'];
      if (!surahMap.containsKey(surahNo)) {
        surahMap[surahNo] = SurahBookmarks(
          surahNo: surahNo,
          surahName: row['surath_name'],
          bookmarkCount: row['bookmark_count'],
          bookmarks: [],
        );
      }
      surahMap[surahNo]!.bookmarks.add(Bookmark.fromMap(row));
    }

    return surahMap.values.toList();
  }

  Future<List<Translator>> fetchTranslators() async {
    final db = await database;

    String query = """
      SELECT 'English' AS language, id, translator_name FROM en_translator WHERE id != 3
      UNION ALL
      SELECT 'Malayalam' AS language, id, translator_name FROM ma_translator;
    """;
    List<Map<String, dynamic>> results = await db.rawQuery(query);

    List<Translator> translators =
        results.map((row) => Translator.fromMap(row)).toList();

    return translators;
  }
}
