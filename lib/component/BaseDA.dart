// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:coresystem/Core/BaseResponse.dart';
// import 'package:coresystem/Core/Header.dart';
// import 'package:coresystem/Core/userService.dart';
// import 'package:dio/dio.dart';
// import 'package:dio/src/options.dart' as OptionsDio;
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart' as permission;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Constant/PrefKey.dart';
//
// class BaseDA {
//   /// lấy file từ URL và lưu vào bộ nhớ máy
//   static Future<String> downloadAndSaveFile(String url, String fileName) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/$fileName';
//     final response = await http.get(Uri.parse(url));
//     final file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }
//
//   /// lấy dạng Uint8List từ URL
//   static Future<Uint8List> getUint8ListFromUrl(String url) async {
//     final response = await http.get(Uri.parse(url));
//     return response.bodyBytes;
//   }
//
//   static Future<BasicResponse<T>> post<T>(String url, dynamic obj, T Function(Object json) fromJson,
//       {String token, String logActive, String apiversion = '1.0'}) async {
//     obj ??= {};
//     final responsefinal = BasicResponse<T>();
//     try {
//       final storage = FlutterSecureStorage();
//       final checkLogin = await storage.read(key: 'IsLogin');
//       final prefs = await SharedPreferences.getInstance();
//
//       final headers = Header.getHeader(
//         apiversion,
//         token,
//         logActive,
//         checkLogin,
//         'application/json',
//         true,
//         (prefs.getString(PrefsKey.LANGUAGES) ?? 'vi') == 'vi',
//       );
//
//       final jsonObj = obj == null ? null : json.encode(obj);
//
//       print('POST:\n-URL: $url \n-BODY: $jsonObj');
//       final response = await http.post(Uri.parse(url), headers: headers, body: jsonObj);
//
//       print('POST RESPONSE:\n-URL: $url \n-CODE: ${response?.statusCode} \n-BODY: ${response?.body}');
//       final respone = json.decode(response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Handle trường hợp data k phải object hoặc list
//         if ((!respone['data'].toString().startsWith('[')) && (!respone['data'].toString().startsWith('{'))) {
//           responsefinal.DataOther = respone['data'];
//         } else {
//           responsefinal.data = fromJson(respone['data']);
//         }
//
//         responsefinal.code = respone['statusCode'];
//         responsefinal.message = respone['errorDescription'];
//         responsefinal.result = respone['statusCode'] == 1 ? true : false;
//       } else {
//         /**
//          * 1002	Cần cập nhật mật khẩu lần đầu và cập nhật thông tin cá nhân
//          * 1000	Tài khoản hoặc mật khẩu không đúng!
//          * 1003	Tài khoản hoặc mật khẩu không đúng!
//          * 1004	Tài khoản không tồn tại trên hệ thống.*/
//
//         if (respone['statusCode'] == 1002 ||
//             respone['statusCode'] == 1000 ||
//             respone['statusCode'] == 1003 ||
//             respone['statusCode'] == 1004) {
//           responsefinal.code = respone['statusCode'];
//         } else {
//           responsefinal.code = response.statusCode;
//         }
//
//         responsefinal.message = respone['errorDescription'];
//         responsefinal.result = respone['statusCode'] == 1 ? true : false;
//       }
//     } catch (e) {
//       print(e);
//       return responsefinal;
//     }
//     return responsefinal;
//   }
//
//   static Future<BasicResponse<T>> put<T>(String url, dynamic obj, T Function(Object json) fromJson,
//       {String token, String logActive, String apiversion = '1.0'}) async {
//     obj ??= {};
//     final responsefinal = BasicResponse<T>();
//     try {
//       final storage = FlutterSecureStorage();
//       final checkLogin = await storage.read(key: 'IsLogin');
//       final prefs = await SharedPreferences.getInstance();
//
//       final headers = Header.getHeader(
//         apiversion,
//         token,
//         logActive,
//         checkLogin,
//         'application/json',
//         true,
//         (prefs.getString(PrefsKey.LANGUAGES) ?? 'vi') == 'vi',
//       );
//
//       final jsonObj = obj == null ? null : json.encode(obj);
//
//       print('PUT:\n-URL: $url \n-BODY: $jsonObj');
//       final response = await http.put(Uri.parse(url), headers: headers, body: jsonObj);
//
//       print('PUT RESPONSE:\n-URL: $url \n-CODE: ${response?.statusCode} \n-BODY: ${response?.body}');
//       final respone = json.decode(response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Handle trường hợp data k phải object hoặc list
//         if ((!respone['data'].toString().startsWith('[')) && (!respone['data'].toString().startsWith('{'))) {
//           responsefinal.DataOther = respone['data'];
//         } else {
//           responsefinal.data = fromJson(respone['data']);
//         }
//
//         responsefinal.code = respone['statusCode'];
//         responsefinal.message = respone['errorDescription'];
//         responsefinal.result = respone['statusCode'] == 1 ? true : false;
//       } else {
//         /**
//          * 1002	Cần cập nhật mật khẩu lần đầu và cập nhật thông tin cá nhân
//          * 1000	Tài khoản hoặc mật khẩu không đúng!
//          * 1003	Tài khoản hoặc mật khẩu không đúng!
//          * 1004	Tài khoản không tồn tại trên hệ thống.*/
//
//         if (respone['statusCode'] == 1002 ||
//             respone['statusCode'] == 1000 ||
//             respone['statusCode'] == 1003 ||
//             respone['statusCode'] == 1004) {
//           responsefinal.code = respone['statusCode'];
//         } else {
//           responsefinal.code = response.statusCode;
//         }
//
//         responsefinal.message = respone['errorDescription'];
//         responsefinal.result = respone['statusCode'] == 1 ? true : false;
//       }
//     } catch (e) {
//       print(e);
//       return responsefinal;
//     }
//     return responsefinal;
//   }
//
//   static Future<BasicResponse<T>> get<T>(
//     String url,
//     T Function(Object json) fromJson, {
//     String logActive,
//     String apiversion = '1.0',
//
//     /// Bắt case api trả ra link url view hoặc download file
//     bool isCatchDataOther = false,
//   }) async {
//     final responsefinal = BasicResponse<T>();
//     try {
//       final storage = FlutterSecureStorage();
//       final checkLogin = await storage.read(key: 'IsLogin');
//       final prefs = await SharedPreferences.getInstance();
//
//       final headers = Header.getHeader(
//         apiversion,
//         null,
//         logActive,
//         checkLogin,
//         'application/json',
//         false,
//         (prefs.getString(PrefsKey.LANGUAGES) ?? 'vi') == 'vi',
//       );
//       print('GET: \n-URL: $url');
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//       print('GET RESPONSE\n-URL: $url \n-CODE: ${response?.statusCode} \n-BODY: ${response?.body}');
//
//       if (isCatchDataOther) {
//         responsefinal.result = response.statusCode == 200;
//         responsefinal.DataOther = response.body;
//       }
//
//       final respone = json.decode(response.body);
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         responsefinal.data = fromJson != null ? fromJson(respone['data']) : respone['data'];
//         responsefinal.code = respone['statusCode'];
//         responsefinal.message = respone['errorDescription'];
//         responsefinal.result = respone['statusCode'] == 1 ? true : false;
//
//         // print(response.body);
//         try {
//           if (responsefinal.code == 800) {
//             await UserService.logOutExpriseToken();
//           }
//           if (responsefinal.code == 401) {
//             // headers.update(
//             //     'Authorization', (value) => 'Bearer ${UserService.token}');
//
//             // final response = await http.get(Uri.parse(url), headers: headers);
//             // if (response.statusCode == 200 || response.statusCode == 201) {
//             //   baseResponse.fromJson(json.decode(response.body));
//             // } else {
//             //   baseResponse.code = response.statusCode;
//             // }
//             await UserService.logOutExpriseToken();
//           }
//         } catch (e) {
//           print(e);
//         }
//       } else {
//         responsefinal.code = response.statusCode;
//         responsefinal.message = respone['errorDescription'];
//         responsefinal.result = respone['statusCode'] == 1 ? true : false;
//       }
//     } catch (e) {
//       print(e);
//       return responsefinal;
//     }
//     return responsefinal;
//   }
//
//   // static Future<userTokenItemModel> RefreshToken(String url) async {
//   //   final response = await post(url, null, userTokenItemModel());
//   //   if (response.code != 200) {
//   //     await UserService.logOutExpriseToken();
//   //   }
//   //   return response;
//   // }
//
//   static Future<String> DownloadPostFile(
//     String url,
//     String fileName, {
//     String token,
//     String logActive,
//     String apiversion = '1.0',
//   }) async {
//     final storage = FlutterSecureStorage();
//     final checkLogin = await storage.read(key: 'IsLogin');
//     final prefs = await SharedPreferences.getInstance();
//
//     final headers = Header.getHeader(
//       apiversion,
//       token,
//       logActive,
//       checkLogin,
//       'application/json',
//       true,
//       (prefs.getString(PrefsKey.LANGUAGES) ?? 'vi') == 'vi',
//     );
//
//     bool isGrantedStorage;
//
//     if (Platform.isAndroid) {
//       isGrantedStorage = await permission.Permission.storage.request().isGranted;
//     } else {
//       isGrantedStorage = await permission.Permission.photos.request().isGranted;
//     }
//
//     print('URL download: $url');
//
//     if (!isGrantedStorage) {
//       await permission.openAppSettings();
//       return '1';
//     } else {
//       try {
//         File file;
//         if (Platform.isAndroid) {
//           file = File('/storage/emulated/0/Download/$fileName');
//           var i = 1;
//           print('file exists: ${file.existsSync()}');
//
//           while (file.existsSync()) {
//             file = File(
//                 '/storage/emulated/0/Download/${fileName.substring(0, fileName.lastIndexOf('.'))}_$i.${fileName.split('.').last}');
//             i++;
//           }
//         } else {
//           final storageDir = await getApplicationDocumentsDirectory();
//           file = File('${storageDir.path}/$fileName');
//         }
//
//         final res = await Dio().get(
//           url,
//           options: OptionsDio.Options(
//             responseType: ResponseType.bytes,
//             followRedirects: false,
//             headers: headers,
//           ),
//         );
//
//         final raf = file.openSync(mode: FileMode.write);
//         raf.writeFromSync(res.data);
//         await raf.close();
//
//         return file.path;
//       } on Exception catch (e) {
//         print(e);
//         return null;
//       }
//     }
//   }
// }
