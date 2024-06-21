import 'package:dio/dio.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  // ignore: unused_field
  final Dio _dio;

  ErrorInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

// @override
// onRequest(RequestOptions options) async {
//   // var connectivityResult = await (new Connectivity().checkConnectivity());
//   // if (connectivityResult == ConnectivityResult.none) {
//   //   return _dio.resolve(new ResultData(
//   //       Code.errorHandleFunction(Code.NETWORK_ERROR, "", false),
//   //       false,
//   //       Code.NETWORK_ERROR));
//   // }
//   return options;
// }
}