import 'dart:convert';


import '../../models/basic_response_model.dart';


class ResultData {
  var data;
  bool result;
  int? code;
  var headers;
  Error? error;

  ResultData(this.data, this.result, this.code, {this.headers, this.error}) {
    if (data.toString().contains("error") ||
        data.toString().contains('Error')) {
      setError(data.toString());
      // setErrorSuccess(data.toString());
    }
  }

  void setError(String strResponse) {
    try {
      var res = json.decode(strResponse);
      var message = json.decode(res['error']['message']);
      print(message);
      print(res['error']["message"]);
      error = message != null ? Error.fromJson(message) : null;
    } catch (e) {
      Error error = Error(status: 404, message: e.toString());
      this.error = error;
    }
  }

  void setErrorSuccess(String strResponse) {
    try {
      var res = jsonDecode(strResponse);
      BasicResponseModel basicModel = BasicResponseModel.fromJson(res);
      Error error = Error(status: 404, message: basicModel.error ?? "Lỗi");
      this.error = error;
    } catch (e) {
      Error error = Error(status: 404, message: e.toString());
      this.error = error;
    }
  }
}

class Error {
  Error({
    this.code,
    this.status,
    required this.message,
  });

  String? code;
  int? status;
  String message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"] ?? "0",
        status: json["status"] ?? "0",
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
