import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/basic_response_model.dart';
import 'code.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/response_interceptor.dart';
import 'result_data.dart';

class HttpManager {
  Dio _dio = new Dio();

  // final TokenInterceptor _tokenInterceptors = new TokenInterceptor();

  HttpManager() {
    // _dio.interceptors.add(new HeaderInterceptor());

    // _dio.interceptors.add(_tokenInterceptors);

    _dio.interceptors.add(LogsInterceptor());

    _dio.interceptors.add(ErrorInterceptor(_dio));

    _dio.interceptors.add(ResponseInterceptor());
  }

  ResultData resultError(DioException e, bool noTip) {
    Response? errorResponse = e.response;
    var messageError = e.message ?? "";
    print('e.response!.statusCode: ${e.response?.statusCode}');
    var error = Error(
      status: errorResponse?.statusCode,
      message: Code.errorHandleFunction(
              errorResponse?.statusCode, errorResponse?.data, noTip)
          .toString(),
    );
    print(error);
    if (e.error is SocketException) {
      error = Error(
        message: 'Kiểm tra lại kết nối internet',
        status: Code.NETWORK_ERROR,
      );
    } else if (messageError.contains('HttpException')) {
      error = Error(
        message:
            'Lỗi khi tải dữ liệu, thử kiểm tra lại kết nối internet và thử lại',
        status: Code.NETWORK_ERROR,
      );
    } else if (messageError.contains('Connecting timed out')) {
      error = Error(
        message: 'Kiểm tra lại kết nối internet',
        status: Code.NETWORK_ERROR,
      );
    } else if (messageError.contains('Token hết hạn') ||
        messageError.contains('Token hết hạn')) {
      error = Error(
        message: 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại',
        status: 0,
      );
    } else if (e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      error = Error(
        message: 'Kiểm tra lại kết nối internet',
        status: Code.NETWORK_TIMEOUT,
      );
    }

    return ResultData(
      '{"result":false,"code":${error.code},"error":${json.encode(error.toJson())}}',
      false,
      error.status,
      error: error,
    );
  }

  Future<ResultData> upload(
      url, formData, Map<String, dynamic> header, Options? option) async {
    Map<String, dynamic> headers = HashMap();
    if (header.isNotEmpty) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    }

    Response? response;
    try {
      response = await _dio.post(
        url,
        data: formData,
        options: option,
      );
    } on DioException catch (e) {
      return resultError(e, false);
    } catch (e) {
      print('=================DATA RESPONSE EXCEPTION===================');
      print(e.toString());
      var error = Error(message: 'Lỗi, vui lòng thử lại sau');
      return ResultData(
        json.encode(error.toJson()),
        false,
        0,
        error: error,
      );
    }

    try {
      json.decode(response.data);
    } catch (e) {
      print('=================DATA EXCEPTION===================');
      print(e.toString());
      var error = Error(message: 'Lỗi, vui lòng thử lại sau');
      return ResultData(
        '{"result":false,"code":${error.code},"error": ${json.encode(error.toJson())}}',
        false,
        0,
        error: error,
      );
    }

    return ResultData(response.data, true, response.statusCode!);
  }

  Future<ResultData> netFetch(
    url,
    params,
    Map<String, dynamic> header,
    Options? option, {
    noTip = false,
    isFormData = false,
  }) async {
    Map<String, dynamic> headers = new HashMap();
    if (header.isNotEmpty) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    Response? response;
    try {
      response = await _dio.request(
        url,
        data: isFormData ? FormData.fromMap(params) : params,
        options: option,
      );
      jsonDecode(response.data);
    } on DioException catch (e) {
      return resultError(e, noTip);
    } catch (e) {
      print('=================DATA RESPONSE EXCEPTION===================');
      print(e.toString());
      var error = Error(message: 'Lỗi, vui lòng thử lại sau');
      return ResultData(
        // '{"result":false,"code":${error.code},"error":${json.encode(error.toJson())}}',
        json.encode(error.toJson()),
        false,
        0,
        error: error,
      );
    }

    try {
      String data = response.data;
      if (data.toString().contains("error") ||
          data.toString().contains('Error')) {
        // setError(data.toString());
        var res = jsonDecode(data);
        BasicResponseModel basicModel = BasicResponseModel.fromJson(res);
        if (basicModel.status == 200) {
          return ResultData(response.data, true, response.statusCode!);
        }
        return ResultData(
          basicModel.data,
          false,
          0,
          error: Error(
            code: basicModel.data,
            status: 404,
            message: basicModel.error ?? "Lỗi",
          ),
        );
      }
    } catch (e) {
      print('=================DATA EXCEPTION===================');
      print(e.toString());
      var error = Error(message: 'Lỗi, vui lòng thử lại sau');
      // BasicResponseModel bug =
      return ResultData(
        '{"result":false,"code":${error.code},"error": ${json.encode(error.toJson())}}',
        false,
        0,
        error: error,
      );
    }

    return ResultData(response.data, true, response.statusCode!);
  }

  // clearAuthorization() {
  //   _tokenInterceptors.clearAuthorization();
  // }

  // getAuthorization() async {
  //   return _tokenInterceptors.getAuthorization();
  // }
}

final HttpManager httpManager = new HttpManager();
