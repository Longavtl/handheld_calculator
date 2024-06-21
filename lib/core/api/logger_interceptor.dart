import 'dart:developer';

import 'package:dio/dio.dart';

final dioLoggerInterceptor =
InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
  String headers = "";
  options.headers.forEach((key, value) {
    headers += "| $key: $value";
  });

  _log(
      "┌------------------------------------------------------------------------------");
  _log('''| Request: ${options.method} ${options.uri.toString()}
| ${options.data.toString()}
| Headers:\n$headers''');
  _log(options.uri.toString());
  _log(
      "├------------------------------------------------------------------------------");
  handler.next(options); //continue
}, onResponse: (Response response, handler) async {
  _log("| Response [code ${response.statusCode}]:"
      " ${response.data.toString()}");
  _log(
      "└------------------------------------------------------------------------------");
  handler.next(response); //continue
}, onError: (DioException error, handler) async {
  _log("| Error: ${error.error}: "
      "${error.response.toString()}");
  _log(
      "└------------------------------------------------------------------------------");
  handler.next(error); //continue
});

void _log(String message) {
  log(message, name: 'API LOG');
}