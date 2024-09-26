import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static final storage = FlutterSecureStorage();

  static void saveData({
    required var key,
    required var value,
  }) async {
    return await storage.write(key: key, value: value);
  }

  static dynamic GetData({
    required var key,
  }) async {
    return await storage.read(key: key);
  }

  //Map<String, String> allValues = await CacheHelper.storage.readAll();
  //allValues['']

  static Future<String?> getData2(String s) async {
    Map<String, String> allValues = await CacheHelper.storage.readAll();
    return allValues[s];
  }
}
