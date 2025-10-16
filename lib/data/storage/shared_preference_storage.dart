import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite_offline/data/storage/local_storage.dart';

class SharedPreferenceStorage implements LocalStorage {
  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> create<T>({required String key, required T data}) async {
    final i = await getInstance();
    if (data is String) {
      return i.setString(key, data);
    } else if (data is int) {
      return i.setInt(key, data);
    } else if (data is double) {
      return i.setDouble(key, data);
    } else if (data is bool) {
      return i.setBool(key, data);
    } else if (data is List<String>) {
      return i.setStringList(key, data);
    } else {
      log("Tipo não suportado");
      return false;
    }
  }

  @override
  Future<bool> delete({required String key}) async {
    final i = await getInstance();
    return i.remove(key);
  }

  @override
  Future<T?> getData<T>({required String key}) async {
    final i = await getInstance();
    return i.get(key) as T?;
  }
}
