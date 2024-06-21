import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:handheld_calculator/core/api/status_code.dart';

import '../error/exception.dart';
import '/di.dart' as di;
import 'api_consumer.dart';
import 'api_endpoint.dart';
import 'debug_log_interceptor.dart';

class DioConsumer extends ApiConsumer {
  final Dio dioClient;

  DioConsumer({required this.dioClient}) {
    (dioClient.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dioClient.options
      ..baseUrl = ApiEndPoints().setBaseUrl("")
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };

    //dioClient.interceptors.add(dioLoggerInterceptor);
    if (kDebugMode) {
      dioClient.interceptors.add(di.sl<DebugLogInterceptor>());
      //dioClient.interceptors.add(dioLoggerInterceptor);
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dioClient.get(
        path,
        queryParameters: queryParams,
      );

      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  @override
  Future post(String path, Map<String, dynamic>? bodyParams) async {
    try {
      final response = await dioClient.post(path,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
          }),
          data: bodyParams);

      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  // @override
  // Future<dynamic> postUpload(String path, FormData formData) async {
  //   try {
  //     final response = await dioClient.post(path,
  //         options: Options(headers: {
  //           HttpHeaders.contentTypeHeader: "multipart/form-data",
  //         }),
  //         data: formData);

  //     return _handleResponseAsJson(response);
  //   } on DioException catch (error) {
  //     _handleDioException(error);
  //   }
  // }

  @override
  Future<dynamic> put(String path, Map<String, dynamic>? bodyParams) async {
    try {
      final response = await dioClient.put(path,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: bodyParams);

      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  @override
  Future delete(String path, {Map<String, dynamic>? bodyParams}) async {
    try {
      final response = await dioClient.delete(path,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: bodyParams);

      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();

          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.connectionError:
        throw const NoInternetConnectionException();
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();
    }
  }
}
