import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../core/db_helper/db_helper.dart';
import '../models/bookmark_model.dart';

class DbProvider with ChangeNotifier {
  final DBHelper dbHelper = DBHelper();
  List<Map<String, dynamic>>? randomAyath;
  List<Map<String, dynamic>>? allSurath;
  Future fetchRandomAyath() async {
    randomAyath = await dbHelper.randomAyath();
    log('random ayath is---$randomAyath');
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>>? _futureSurahList;
  Future<List<Map<String, dynamic>>>? get futureSurahList => _futureSurahList;

  void fetchAllSurath({String? search}) {
    _futureSurahList = dbHelper.getAllSurah(searchQuery: search);
    notifyListeners();
  }

  List<Map<String, dynamic>>? surahDetails;
  bool isLoading = false;
  void getSurahDetail(int surahNo,
      {String? key, bool needLoader = true}) async {
    isLoading = needLoader;
    surahDetails = await dbHelper.getSurahDetails(surahNo, key: key);
    isLoading = false;
    notifyListeners();
  }

  String selectedLanguage = 'English';
  switchLanguage({String? value, int? id}) {
    print(value);
    getSurahDetail(id!, key: value, needLoader: false);
    selectedLanguage = value!;
    notifyListeners();
  }

  Future<bool> addBookMark(
      {int? surahNo, int? ayathNo, String? ayath, String? translation}) async {
    bool? isAdded = await dbHelper.addBookmark(
        surahNo: surahNo,
        ayath: ayath,
        ayathNo: ayathNo,
        translation: translation);
    return isAdded;
  }

  // List<Map<String, dynamic>>? bookmarkedAyath;
  //
  // Future<List<Map<String, dynamic>>>? _bookmarkedList;
  // Future<List<Map<String, dynamic>>>? get bookmarkedList => _bookmarkedList;
  //
  // void getBookmarkedAyat() async {
  //   _bookmarkedList = dbHelper.getBookmarkedAyaths();
  // }

  void clearBookMark() async {
    await dbHelper.clearBookmarks();
  }

  Future<bool> removeBookMark({int? surahNo, int? ayathNo}) async {
    bool? isDeleted =
        await dbHelper.removeBookmark(surahNo: surahNo, ayathNo: ayathNo);
    return isDeleted;
  }


  List<SurahBookmarks>? bookmarkedAyath;
  bool? isLoadingBk = false;
  void fetchBookmarkedAyath() async {
    isLoading = true;
    bookmarkedAyath = await dbHelper.getBookmark();
    isLoading = false;
    notifyListeners();
  }

  removeAyath({int? surahNo, Bookmark? bookmarkAyath}) {
    SurahBookmarks selectedAyath;
    selectedAyath = bookmarkedAyath!.firstWhere((e) => e.surahNo == surahNo);
    selectedAyath.bookmarks
        .removeWhere((e) => e.ayahNo == bookmarkAyath?.ayahNo);
    notifyListeners();
  }
}
