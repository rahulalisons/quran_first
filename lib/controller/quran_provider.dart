import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../db_helper/db_helper.dart';
import '../models/JuzSurahItem.dart';
import '../screen/home/home.dart';
import '../screen/quran/quran_screen.dart';

class QuranProvider with ChangeNotifier {
  int? currentIndex = 0;
  void changeCurrentIndex({int? index}) {
    currentIndex = index;
    notifyListeners();
  }

  int selectedIndex = 0;
  final List<Widget> pages = <Widget>[
    HomeScreen(),
    QuranScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  bottomnaviagtionSwitch(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  int? juzOrSurah = 0;
  switchIndex(int index) {
    juzOrSurah = index;
    notifyListeners();
  }

  double? ayatTextSize = 15.sp;

  changeTextSize({double? size}) {
    ayatTextSize = size;
    print('size iss---$ayatTextSize');
    notifyListeners();
  }

  bool? showTranslation = true;
  bool? showTransliteration = true;
  switchOptions({bool? value, bool isTranslation = true}) {
    if (isTranslation) {
      showTransliteration = value;
    } else {
      showTranslation = value;
    }
    notifyListeners();
  }

  final DBHelper dbHelper = DBHelper();
  List<Map<String, dynamic>>? arData;
  List<Map<String, dynamic>>? enData;
  List<Map<String, dynamic>>? maData;
  List<Map<String, dynamic>>? arAyah;
  List<Map<String, dynamic>>? maAyah;
  List<Map<String, dynamic>>? enAyah;
  List<Map<String, dynamic>>? count;
  Future fetchChapters() async {
    arData = await dbHelper.getAllEnSurah(code: 'ar');
    maData = await dbHelper.getAllEnSurah(code: 'ma');
    enData = await dbHelper.getAllEnSurah(code: 'en');
    // arAyah = await dbHelper.getAllAyath(code: 'ar');
    // enAyah = await dbHelper.getAllAyath(code: 'en');
    // maAyah = await dbHelper.getAllAyath(code: 'ma');
    count = await dbHelper.getSurahAyahCounts(code: 'en');
    notifyListeners();
  }

  List<Map<String, dynamic>>? juz;

  Future<List<Map<String, dynamic>>?>? fetchJuz() async {
    juz = await dbHelper.getAllJuz();
    notifyListeners();
  }

  List<JuzhData>? juzhDataList;

  Future fetchJuzSurahData() async {
    juzhDataList = await dbHelper.fetchJuzhData();
    notifyListeners();
  }

  List<Map<String, dynamic>>? AyathBysurath;
  List<Map<String, dynamic>>? arAyathBysurath;

  Future<List<Map<String, dynamic>>?>? ayathBySurath({
    int? surahNo,
    String? code,
  }) async {
    AyathBysurath =
        await dbHelper.getAyathsBySurah(code: code ?? 'en', surahNo: surahNo);
    arAyathBysurath =
        await dbHelper.getAyathsBySurah(code: 'ar', surahNo: surahNo);
    log('----$AyathBysurath');
    log('----$arAyathBysurath');
    notifyListeners();
  }
}
