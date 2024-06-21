import 'dart:convert';

LoginModelResult loginModelFromJson(String str) =>
    LoginModelResult.fromJson(json.decode(str));

String resultLoginToJson(LoginModelResult data) => json.encode(data.toJson());

class LoginModelResult {
  bool? success;
  String? errorCode;
  Data? data;
  String? message;

  LoginModelResult({this.success, this.errorCode, this.data, this.message});

  LoginModelResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['errorCode'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  User? user;

  Data({this.accessToken, this.refreshToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? phone;
  String? avatar;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? hasPassword;

  User(
      {this.sId,
        this.phone,
        this.avatar,
        this.isVerified,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.hasPassword});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    avatar = json['avatar'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    hasPassword = json['hasPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['isVerified'] = isVerified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['hasPassword'] = hasPassword;
    return data;
  }
}
