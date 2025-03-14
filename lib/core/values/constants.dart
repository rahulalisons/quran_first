import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class AppConstants {
  static const iconPath = 'assets/app/icons/';
  static const imagePath = 'assets/app/images/';
  static const animationPath = 'assets/app/animations/';
  static const svgPath = 'assets/app/svg/';

}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String ?userId;
String KuserId='userId';

Future<void> launch(String url) async {
  if (!await launchUrlString(url)) {
    throw Exception('Could not launch $url');
  }
}

Future<void> launchWhatsapp(String phone) async {
  var url = '';
  if (Platform.isIOS) {
    url = "whatsapp://wa.me/$phone/?text=''";
  } else {
    url = "whatsapp://send?phone=$phone&text=''";
  }
  try {
    if (!await launchUrlString(url)) {
      throw Exception('Could not launch whatsapp');
    }
  } catch (e) {
    if (Platform.isAndroid) {
      url = "https://wa.me/$phone/?text=${Uri.parse('')}"; // new line
    } else {
      url =
          "https://api.whatsapp.com/send?phone=$phone=${Uri.parse('')}"; // new line
    }
    if (!await launchUrlString(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

Future<void> launchInstagram(String username) async {
  var nativeUrl = "instagram://user?username=$username";
  var webUrl = "https://www.instagram.com/$username";
  if (username.contains('https')) {
    webUrl = username;
    nativeUrl = username;
  }
  try {
    await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
  } catch (e) {
    print(e);
    await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
  }
}

Future<void> launchFaceBook(String username) async {
  var nativeUrl = "facebook://user?username=$username";
  var webUrl = "https://www.facebook.com/$username";
  if (username.contains('https')) {
    webUrl = username;
    nativeUrl = username;
  }

  try {
    await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
  } catch (e) {
    print(e);
    await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
  }
}

Future<void> launchPhone(String phone) async {
  if (!await launchUrl(Uri(scheme: 'tel', host: phone))) {
    throw Exception('Could not launch phone');
  }
}

Future<void> launchMail(String mail) async {
  if (!await launchUrl(Uri(scheme: 'mailto', path: mail))) {
    throw Exception('Could not launch mail');
  }
}




