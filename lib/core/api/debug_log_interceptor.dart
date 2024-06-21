import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DebugLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("┌------------------------------------------------------------------------------");
    debugPrint('||REQUEST[${options.method}] => PATH: ${options.uri}');

    // In các cặp key-value trong Headers với dấu || ở đầu dòng
    options.headers.forEach((key, value) {
      debugPrint('||$key: $value');
    });

    debugPrint('||Request Data: ${options.data}');
    debugPrint('└------------------------------------------------------------------------------');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("┌------------------------------------------------------------------------------");
    debugPrint('||RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}');

    // In các cặp key-value trong Headers với dấu || ở đầu dòng
    response.headers.forEach((key, value) {
      debugPrint('||$key: $value');
    });

    debugPrint('||Response Data: ${response.data}');
    debugPrint('└------------------------------------------------------------------------------');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("┌------------------------------------------------------------------------------");
    debugPrint('||ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
    debugPrint('||Error Message: ${err.message}');

    // In các cặp key-value trong Headers của Error Response với dấu || ở đầu dòng
    err.response?.headers.forEach((key, value) {
      debugPrint('||$key: $value');
    });

    debugPrint('||Error Response: ${err.response?.data}');
    debugPrint('└------------------------------------------------------------------------------');
    return super.onError(err, handler);
  }
}