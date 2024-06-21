import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefHelper{
  static late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future <void> setBool(String key, dynamic value) async {
    await prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  Future <void> setString(String key, dynamic value) async {
    await prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future <void> setInt(String key, dynamic value) async {
    await prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return prefs.getInt(key);
  }
  Future<void> removeValue(String key) async{
    await prefs.remove(key);
  }
}

class LocalPrefConstants{
  static const String kToken = "kToken";
  static const String kIsShowListUploading = "kIsShowListUploading";
  static const String kEnableBiometric = "kEnableBiometric";
  static const String kPassword = "kPassword";
  static const String kEmail = "kEmail";
  static const String kSaveStateAccLogin = "kSaveStateAccLogin";
  static const String kSaveFolder = "kSaveFolder";
  static const String kShowDialogExpired5Days = "kShowDialogExpired5Days";
  static const String kLanguage = "kLanguage";
  static const String kNotification = "kNotification";
  static const String kAutoSync = "kAutoSync";
  static const String kAutoSyncOption = "kAutoSyncOption";
  static const String kIndexDrawer = "kIndexDrawer";
}