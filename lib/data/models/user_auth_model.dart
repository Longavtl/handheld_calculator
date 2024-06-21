class UserAuthModel<T> {
  final bool? success;
  final String? errorCode;
  final String? message;
  final T? data;

  UserAuthModel(
      {required this.success,
        required this.errorCode,
        required this.message,
        required this.data});

  factory UserAuthModel.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT) =>
      UserAuthModel(
        success: json['success'],
        errorCode: json['errorCode'],
        message: json['message'],
        data: json['data'] != null ? fromJsonT(json['data']) : null,
      );
}

// check login success data return model
class CheckLoginData {
  final bool hasUser;
  final bool hasPassword;

  CheckLoginData({required this.hasUser, required this.hasPassword});

  factory CheckLoginData.fromJson(Map<String, dynamic> json) => CheckLoginData(
    hasUser: json['hasUser'],
    hasPassword: json['hasPassword'],
  );
}

// otp response data
class OtpData {
  final String? otp;

  OtpData({required this.otp});

  factory OtpData.fromJson(Map<String, dynamic> json) =>
      OtpData(otp: json['otp'] ?? "");
}

// check otp response
class CheckOtpData {
  final bool verify;
  final String accessToken;

  CheckOtpData({required this.verify, required this.accessToken});

  factory CheckOtpData.fromJson(Map<String, dynamic> json) =>
      CheckOtpData(verify: json['verify'], accessToken: json['accessToken']);
}

// login data response
class LoginDataModel {
  final int? status; // Changed to int
  final String? token;
  final String? errorMessage;

  LoginDataModel({
    this.status,
    this.token,
    this.errorMessage,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      status: json['status'] ?? 0, // Default value can be adjusted
      token: json['token'] ?? "",
      errorMessage: json['error'] != null ? json['error']['message'] : null,
    );
  }
}

class RegisterOrganizationDataModel {
  final int? status;
  final dynamic error;
  final String? data;

  RegisterOrganizationDataModel({
    this.status,
    this.error,
    this.data,
  });

  factory RegisterOrganizationDataModel.fromJson(Map<String, dynamic> json) {
    return RegisterOrganizationDataModel(
      status: json['status'],
      error: json['error'],
      data: json['data'] ?? "",
    );
  }
}

class RegisterManagementDataModel {
  final int status;
  final dynamic error;
  final dynamic data;

  RegisterManagementDataModel({
    required this.status,
    this.error,
    required this.data,
  });

  factory RegisterManagementDataModel.fromJson(Map<String, dynamic> json) {
    return RegisterManagementDataModel(
      status: json['status'],
      error: json['error'],
      data: json['data'] ?? "",
    );
  }
}

class ForgotPasswordDataModel {
  final int? status; // Changed to int
  final String? errorMessage;
  final dynamic data;

  ForgotPasswordDataModel({
    this.status,
    this.errorMessage,
    this.data
  });

  factory ForgotPasswordDataModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordDataModel
      (
      status: json['status'] ?? 0,
      errorMessage: json['message'] != null ? json['message']['message'] : null,
      data: json['data'] ?? "",
    );
  }
}

class ProfileDataModel {
  final UserAuthInfo userAuthInfo;

  ProfileDataModel({required this.userAuthInfo});

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(userAuthInfo: UserAuthInfo.fromJson(json['data']));
}

class UserAuthInfo {
  final String userId;
  final String phone;
  final String avatar;
  final bool isVerified;
  final String createdAt;
  final String updatedAt;
  final String email;
  final String fullName;
  final String dateOfBirth;
  final String idNo;
  final int type;

  UserAuthInfo(
      {required this.userId,
        required this.phone,
        required this.avatar,
        required this.isVerified,
        required this.createdAt,
        required this.updatedAt,
        required this.idNo,
        required this.dateOfBirth,
        required this.email,
        required this.type,
        required this.fullName});

  factory UserAuthInfo.fromJson(Map<String, dynamic> json) => UserAuthInfo(
    userId: json['_id'] ?? "",
    phone: json['phone'] ?? "",
    avatar: json['avatar'] ?? "",
    isVerified: json['isVerified'] ?? "",
    createdAt: json['createdAt'] ?? "",
    updatedAt: json['updatedAt'] ?? "",
    idNo: json['idNo'] ?? "",
    type: json['type'] ?? 999999,
    email: json['email'] ?? "",
    dateOfBirth: json['dateOfBirth'] ?? "",
    fullName: json['fullName'] ?? "",
  );

  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'phone': phone,
      'avatar': avatar,
      'idNo': idNo,
      'isVerified': isVerified,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'email': email,
      'type': type,
      'dateOfBirth': dateOfBirth,
      'fullName': fullName,
    }..removeWhere((key, value) => value == null);
  }
}