import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quran_first/models/arbic_script_model.dart';

import '../core/utils/helper/custom_dialog.dart';
import '../core/utils/helper/shared_preference.dart';
import '../core/values/constants.dart';
import '../screen/bottom_bar/bottom_bar_section.dart';
import '../screen/home/home.dart';
import '../screen/on_boarding/on_boarding.dart';
import '../screen/prayer_time/prayer_time.dart';
import '../screen/quran/quran_screen.dart';
import '../screen/settings/settings.dart';

class QuranProvider with ChangeNotifier {
  int? currentIndex = 0;
  void changeCurrentIndex({int? index}) {
    currentIndex = index;
    notifyListeners();
  }

  int selectedIndex = 0;
  int previousIndex = 0;
  final List<Widget> pages = <Widget>[
    HomeScreen(),
    QuranScreen(),
    PrayerTime(),
    Settings(),
  ];

  bottomnaviagtionSwitch(int index) {
    previousIndex = selectedIndex;
    selectedIndex = index;
    notifyListeners();
  }

  isFirstTimeOrNot({BuildContext? context}) {
    Timer(const Duration(seconds: 3), () async {
      final bool isFirstTime = await SharedPrefUtil.contains(keyIsFirstTime);
      if (isFirstTime) {
        final bool firstTime = await SharedPrefUtil.getBoolean(keyIsFirstTime);
        if (firstTime) {
          Navigator.pushAndRemoveUntil(
            context!,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
              child: OnBoarding(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context!,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
              child: BottomBarSection(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        Navigator.pushAndRemoveUntil(
          context!,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 500),
            child: OnBoarding(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  int? juzOrSurah = 0;
  switchIndex(int index) {
    juzOrSurah = index;
    notifyListeners();
  }

  // double? ayatTextSize = 15.sp;

  // changeTextSize({double? size}) {
  //   ayatTextSize = size;
  //   print('size iss---$ayatTextSize');
  //   notifyListeners();
  // }

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

  List<Placemark>? currentLocations;
  LocationPermission? permission;
  Future currentLocation(BuildContext context) async {
    bool serviceEnabled;
    // LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // cancelOrder(
      //   canEdit: false,
      //   title:
      //       'Location services are disabled...?\n Please turn on location services to continue. ',
      //   context: context,
      // );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    notifyListeners();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
      notifyListeners();
    }

    if (permission == LocationPermission.deniedForever) {
      cancelOrder(
        submit: () async {
          Navigator.of(context).pop();
          await Geolocator.openAppSettings();
        },
        title:
            'Please enable the location service in your device settings to use this feature...?',
        context: context,
      );
      notifyListeners();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position? position;
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    fetchCurrentLocation(
        latitude: position.latitude, longitude: position.longitude);
    print('location values are--${currentLocations?.first}');
    notifyListeners();
  }

  fetchCurrentLocation({
    double? latitude,
    double? longitude,
  }) async {
    currentLocations = await placemarkFromCoordinates(latitude!, longitude!);
    notifyListeners();
  }

  List<ArabicScript> arabicType = [
    ArabicScript(
        id: 1,
        displayName: 'IndoPak (Majeedi)',
        fontName: 'AlQuran-IndoPak-by-QuranWBW'),
    ArabicScript(
        id: 2,
        fontName: 'UthmanicHafs1Ver09',
        displayName: 'Madinah (Uthmani)'),
    ArabicScript(id: 3, displayName: 'Reem KufiScript', fontName: 'ReemKufi'),
    ArabicScript(
        id: 4, displayName: 'Noto Kufic Script', fontName: 'NotoKufiArabic'),
  ];

  ArabicScript? defaultType = ArabicScript(
      id: 1,
      displayName: 'IndoPak (Majeedi)',
      fontName: 'AlQuran-IndoPak-by-QuranWBW');

  changeScript(ArabicScript value) {
    defaultType = value;
    notifyListeners();
  }

  List<ArabicScript> fontSize = [
    ArabicScript(id: 1, displayName: 'Small', size: 12),
    ArabicScript(id: 2, displayName: 'Medium', size: 15),
    ArabicScript(id: 3, displayName: 'Large', size: 17),
    ArabicScript(id: 4, displayName: 'Extra Large', size: 19),
  ];
  ArabicScript? defaultFontSize =
      ArabicScript(id: 2, displayName: 'Medium', size: 15);

  changeFontSize(ArabicScript value) {
    defaultFontSize = value;
    notifyListeners();
  }
}
