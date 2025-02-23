import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

//! Here The Initialize of cache .
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

//! this method to put data in local database using key

  Future<bool> saveData({required String key, required dynamic value}) async {
    bool result = false;
    if (value is bool) {
      result = await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      result = await sharedPreferences.setString(key, value);
    } else if (value is int) {
      result = await sharedPreferences.setInt(key, value);
    } else {
      result = await sharedPreferences.setDouble(key, value);
    }

    // ✅ طباعة النتيجة لمعرفة إذا كان الحفظ ناجحًا
    print("🔹 Saving [$key]: $value -> Success: $result");
    return result;
  }

//! this method to get data already saved in local database

  dynamic getData({required String key}) {
    var value = sharedPreferences.get(key);
    print("🔹 Retrieving [$key]: $value"); // ✅ طباعة القيم المسترجعة
    return value;
  }

//! remove data using specific key

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

//! this method to check if local database contains {key}
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  Future<bool> clearData({required String key}) async {
    return sharedPreferences.clear();
  }

//! this fun to put data in local data base using key
  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }
}
