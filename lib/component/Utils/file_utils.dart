// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class FileUtils {
//   static Future<String> getDownloadDirectory() async {
//     var directory;
//     bool dirDownloadExists;
//     if (Platform.isIOS) {
//       directory = await getDownloadsDirectory();
//     } else {
//       directory = "/storage/emulated/0/Download/";
//       dirDownloadExists = await Directory(directory).exists();
//       if (!dirDownloadExists) {
//         directory = "/storage/emulated/0/Downloads/";
//       }
//     }
//     return directory;
//   }
//   static Future<void> requestPermission() async {
//     try {
//       // Yêu cầu quyền ghi file
//       var status = await Permission.storage.request();
//       if (status.isGranted) {
//         // Quyền được cấp, tiến hành thực hiện các thao tác ghi file
//         print("Quyền đã được cấp!");
//       } else if (status.isDenied) {
//         // Quyền bị từ chối
//         print("Quyền bị từ chối!");
//       }
//     } on PlatformException catch (e) {
//       print("Lỗi: $e");
//     }
//   }
//   static Future<String?> downloadDestination() async {
//     String? destination;
//     if (Platform.isAndroid) {
//       destination = '/storage/emulated/0/Download/MyLife';
//     } else {
//       destination = (await getApplicationDocumentsDirectory()).path;
//     }
//     return destination;
//   }
//
//   static Future<bool> checkStoragePermission() async {
//     AndroidDeviceInfo? info;
//     final deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       info = await deviceInfo.androidInfo;
//     }
//     if (Platform.isIOS || (info != null && info.version.sdkInt < 29))
//       return Permission.storage.request().isGranted;
//     else
//       return true;
//   }
//
//   static Future<bool> checkAndRequestPermission(
//       Permission permission, Future<void> Function()? openSetting) async {
//     var currentTime = DateTime.now().millisecondsSinceEpoch;
//     if (await permission.isGranted) return true;
//     if (await permission.isLimited) return true;
//     var status = await permission.request();
//     if (status == PermissionStatus.granted ||
//         status == PermissionStatus.limited) return true;
//     if ((DateTime.now().millisecondsSinceEpoch - currentTime) < 300) {
//       if (openSetting != null) {
//         openSetting();
//       }
//       return false;
//     }
//     return false;
//   }
//
//   static Future<Permission> photoPermission() async {
//     if (Platform.isIOS) return Permission.photos;
//     DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//     final androidInfo = await deviceInfoPlugin.androidInfo;
//     if (androidInfo.version.sdkInt >= 33) return Permission.photos;
//     return Permission.storage;
//   }
//
//   static Future<Permission> videoPermission() async {
//     if (Platform.isIOS) return Permission.photos;
//     DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//     final androidInfo = await deviceInfoPlugin.androidInfo;
//     if (androidInfo.version.sdkInt >= 33) return Permission.videos;
//     return Permission.storage;
//   }
//
//   static Future<void> writeToFile(Uint8List data, String path) {
//     final buffer = data.buffer;
//     return new File(path).writeAsBytes(
//         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//   }
// }
