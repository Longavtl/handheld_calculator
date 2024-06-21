// /*
// import 'package:dio/dio.dart';
// import 'package:dlhp/data/data_sources/http/api.dart';
// import 'package:dlhp/data/data_sources/http/result_data.dart';
//
// class AuthenticationRepository {
//   final ApiEndPoints apiEndPoints = ApiEndPoints();
//   final String os = HelperFunc.getPlatform();
//
//   // final _controller = StreamController<AuthenticationStatus>();
//   Future<ResultData> login({
//     required phone,
//     required String otp,
//   }) async {
//     Map<String, dynamic> header = {
//       'accept': 'application/json',
//       'Content-Type': 'application/json',
//       'os-type': 'ANDROID',
//       'app-version': '1.0.0'
//     };
//     Map<String, dynamic> body = {
//       'phone': phone,
//       'otp': otp,
//     };
//     ResultData rest = await httpManager.netFetch(
//         apiEndPoints.getLoginUrl(),
//         body,
//         header,
//         Options(
//           method: 'post',
//           responseType: ResponseType.plain,
//         ));
//     // final resultLogin = resultLoginFromJson(
//     //   rest.data,
//     // );
//
//     return rest;
//   }*/
