import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../core/db_helper/db_helper.dart';
import '../models/bookmark_model.dart';
import '../models/translator_model.dart';

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
  Future getSurahDetail(
    int surahNo, {
    bool needLoader = true,
  }) async {
    isLoading = needLoader;
    surahDetails = await dbHelper.getSurahDetails(surahNo,
        key: selectedTranslator?.language.toLowerCase(),
        translatorId: selectedTranslator?.id);
    log('re------$surahDetails');
    isLoading = false;
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

  List<Translator>? translator;
  Translator? selectedTranslator;

  void fetchTranslator() async {
    translator = await dbHelper.fetchTranslators();
    notifyListeners();
  }

  selectTranslator({
    Translator? value,
    int? surathId,
  }) {
    selectedTranslator = value;
    getSurahDetail(
      needLoader: false,
      surathId!,
    );
    // notifyListeners();
  }

  bool isSharing = false;
  ScreenshotController screenshotController = ScreenshotController();
  Future<void> captureAndShare() async {
    isSharing = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 100));

    screenshotController.capture().then((image) async {
    isSharing = false;
    notifyListeners();
      if (image != null) {
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/ayat.png';
        File(imagePath).writeAsBytesSync(image);

        await Share.shareXFiles([XFile(imagePath)],
            text: "Here is an Ayat for you!");
      }
    });
  }
}
