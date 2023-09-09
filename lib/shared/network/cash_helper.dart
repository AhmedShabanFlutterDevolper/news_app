import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharesPreferences;
  static init() async {
    sharesPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool>? putData({
    required String key,
    required bool value,
  }) async {
    return await sharesPreferences!.setBool('isDark', value);
  }

  static bool? getData({
    required String key,
  }) {
    return sharesPreferences!.getBool(key);
  }
}
