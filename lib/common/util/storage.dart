import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 数据存储
class StorageUtil {
  static StorageUtil _instance = new StorageUtil._();

  factory StorageUtil() => _instance;

  StorageUtil._();

  static SharedPreferences _prefs;

  /// 初始化
  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setBool(String key, bool val) {
    return _prefs.setBool(key, val);
  }

  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
