import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesService._(); // Private constructor to prevent instantiation.

  factory SharedPreferencesService() {
    _instance ??= SharedPreferencesService._();
    return _instance!;
  }

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String getString(String key, {String defaultValue = ''}) {
    return _preferences?.getString(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    return _preferences?.setString(key, value) ?? Future.value();
  }

  // bool
  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences?.getBool(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) async {
    return _preferences?.setBool(key, value) ?? Future.value();
  }

  // int
  int getInt(String key, {int defaultValue = -1}) {
    return _preferences?.getInt(key) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) async {
    return _preferences?.setInt(key, value) ?? Future.value();
  }

  // double
  double getDouble(String key, {double defaultValue = -1}) {
    return _preferences?.getDouble(key) ?? defaultValue;
  }

  Future<void> setDouble(String key, double value) async {
    return _preferences?.setDouble(key, value) ?? Future.value();
  }

  //remove
  void remove(String key) {
    _preferences?.remove(key);
  }
}
