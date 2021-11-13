import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPresService {
  static SharedPresService? _instance;
  static SharedPreferences? _preferences;
  static String userDataKey = 'User';

  static Future<SharedPresService> getInstance() async {
    _instance ??= SharedPresService();

    if (_preferences == null) {
      WidgetsFlutterBinding.ensureInitialized();
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance!;
  }

  Future<void> saveToDisk<T>(String key, T content) async {
    if (content is String) {
      await _preferences!.setString(key, content);
    }
    if (content is bool) {
      await _preferences!.setBool(key, content);
    }
    if (content is int) {
      await _preferences!.setInt(key, content);
    }
    if (content is double) {
      await _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      await _preferences!.setStringList(key, content);
    }
  }

  Object? getFromDisk(String key) {
    final value = _preferences!.get(key);
    return value;
  }

  Future<bool> removeFromDisk(String key) async {
    final value = await _preferences!.remove(key);
    return value;
  }

  void removeUser(){
    removeFromDisk(userDataKey);
  }

  void saveUser(User user) =>
      saveToDisk(userDataKey, json.encode(user.toJson()));

  User? get user {
    var userResponse = getFromDisk(userDataKey);
    if (userResponse == null) {
      return null;
    }
    return User.fromJson(jsonDecode(userResponse.toString()));
  }
    
}
