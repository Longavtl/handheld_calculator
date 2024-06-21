import 'dart:io';
import 'package:dio/dio.dart';
class SaveFile{
  static Future<File> downloadImage(String url,String filePath) async {
    final dio = Dio();
    final response = await dio.get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final file = File(filePath);
    return file.writeAsBytes(response.data);
  }
}