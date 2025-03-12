import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../core/utils/helper/custom_dialog.dart';
import '../screen/home/home.dart';
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
  final List<Widget> pages = <Widget>[
    HomeScreen(),
    QuranScreen(),
    PrayerTime(),
    Settings(),
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
}
