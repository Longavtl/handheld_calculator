import 'dart:convert';

import 'package:dio/dio.dart';

import '../code.dart';
import '../result_data.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    RequestOptions options = response.requestOptions;
    var value;
    try {
      var header = response.headers;
      if (header != null && header.toString().contains("text")) {
        value = ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        value = ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + options.path);
      value = new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
  }
}
