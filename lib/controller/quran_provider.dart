import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
}
