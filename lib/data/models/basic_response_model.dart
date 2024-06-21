class BasicResponseModel {
  int? status;
  String? error;
  dynamic data;

  BasicResponseModel({this.status, this.error, this.data});

  BasicResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['success'] ?? 0;
    error = json['error'] ?? "";
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataToJson = <String, dynamic>{};
    dataToJson['status'] = status;
    dataToJson['error'] = error;
    dataToJson['data'] = data;
    return dataToJson;
  }
}