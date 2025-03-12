import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../core/db_helper/db_helper.dart';

class DbProvider with ChangeNotifier {
  final DBHelper dbHelper = DBHelper();
  List<Map<String, dynamic>>? randomAyath;
  List<Map<String, dynamic>>? allSurath;
  Future fetchRandomAyath() async {
    randomAyath = await dbHelper.randomAyath();
    log('random ayath is---$randomAyath');
    notifyListeners();
  }

  // Future<List<Map<String, dynamic>>> ? fetchAllSurath({String? search}) async {
  //   print('cal api--$search');
  //   // allSurath = await dbHelper.getAllSurah();
  //   // log('random ayath is---$allSurath');
  //   // notifyListeners();
  //   return await dbHelper.getAllSurah(searchQuery:search );
  // }

  Future<List<Map<String, dynamic>>>? _futureSurahList;
  Future<List<Map<String, dynamic>>>? get futureSurahList => _futureSurahList;

  void fetchAllSurath({String? search}) {
    _futureSurahList = dbHelper.getAllSurah(searchQuery: search);
    notifyListeners();
  }

  // List<Map<String, dynamic>>? arData;
  // List<Map<String, dynamic>>? enData;
  // List<Map<String, dynamic>>? maData;
  // List<Map<String, dynamic>>? arAyah;
  // List<Map<String, dynamic>>? maAyah;
  // List<Map<String, dynamic>>? enAyah;
  // List<Map<String, dynamic>>? count;
  // Future fetchChapters() async {
  //   arData = await dbHelper.getAllEnSurah(code: 'ar');
  //   maData = await dbHelper.getAllEnSurah(code: 'ma');
  //   enData = await dbHelper.getAllEnSurah(code: 'en');
  //   count = await dbHelper.getSurahAyahCounts(code: 'en');
  //   notifyListeners();
  // }
}
