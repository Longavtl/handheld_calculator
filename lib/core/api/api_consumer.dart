abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams});
  Future<dynamic> post(String path, Map<String, dynamic>? bodyParams);
  // Future<dynamic> postUpload(String path, FormData formData);
  Future<dynamic> put(String path, Map<String, dynamic>? bodyParams);
  Future<dynamic> delete(String path, {Map<String, dynamic>? bodyParams});
}
