import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  static Future<bool> writeBoolean(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  static Future<bool> getBoolean(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
  static Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }


}
