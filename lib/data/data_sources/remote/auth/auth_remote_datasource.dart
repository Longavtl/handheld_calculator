

import '../../../../config/helper/global_var.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/api_endpoint.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../models/basic_response_model.dart';
import '../../../models/user_auth_model.dart';

abstract class AuthRemoteDataSource {
  // check login
  Future<UserAuthModel> checkLogin({
    String? phone,
  });

  //otp
  Future<UserAuthModel> getOtp({
    String? phone,
  });

  // check otp
  Future<UserAuthModel> checkOtp({CheckOtpParams? otpParams});

  // set first password
  Future<UserAuthModel> setPassword({FirstPassParams? passParams});

  //register
  Future<RegisterOrganizationDataModel> registerOrganization({RegisterOrganizationParams? registerOrganizationParams});

  Future<RegisterManagementDataModel> registerManagement({RegisterManagementParams? registerManagementParams});
  Future<ForgotPasswordDataModel> forgotPassword({ForgotPasswordParams? forgotPasswordParams});

  // login
  Future<LoginDataModel> login({LoginParams? loginParams});

  // logout
  Future<UserAuthModel> logout({LogoutParams? logoutParams});

  Future<BasicResponseModel> removeUser({RemoveUserParams? params});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiConsumer apiConsumer;
  ApiEndPoints apiEndPoints;

  AuthRemoteDataSourceImpl({required this.apiConsumer, required this.apiEndPoints});

  //Parsing data
  T checkLoginData<T>(Map<String, dynamic> json) {
    return CheckLoginData.fromJson(json) as T;

    // if (T == CheckLoginData) {
    // if (T == CheckLoginData.fromJson(json)) {
    //   return CheckLoginData.fromJson(json) as T;
    // }
    // return null as T;
    // throw ArgumentError('Unsupported type: $T');
  }

  T otpData<T>(Map<String, dynamic> json) {
    return OtpData.fromJson(json) as T;
  }

  T checkOtpData<T>(Map<String, dynamic> json) {
    return CheckOtpData.fromJson(json) as T;
  }

  // login response data type
  T loginResultData<T>(Map<String, dynamic> json) {
    return LoginDataModel.fromJson(json) as T;
  }

  // T is null
  T parseNull<T>(Map<String, dynamic> json) {
    return null as T;
  }

  @override
  Future<UserAuthModel> checkLogin({String? phone}) async {
    var params = {"phone": phone};

    final response = await apiConsumer.post(apiEndPoints.getCheckLoginUrl(), params);
    return UserAuthModel.fromJson(response, checkLoginData);
  }

  @override
  Future<UserAuthModel> getOtp({String? phone}) async {
    var params = {"phone": phone};

    final response = await apiConsumer.post(apiEndPoints.getAuthOtpUrl(), params);
    return UserAuthModel.fromJson(response, otpData);
  }

  @override
  Future<UserAuthModel> checkOtp({CheckOtpParams? otpParams}) async {
    var params = {"phone": otpParams?.phone, "otp": otpParams?.otp};

    final response = await apiConsumer.post(apiEndPoints.getCheckOtpUrl(), params);
    return UserAuthModel.fromJson(response, checkOtpData);
  }

  @override
  Future<UserAuthModel> setPassword({FirstPassParams? passParams}) async {
    var params = {"phone": passParams?.phone, "newPassword": passParams?.newPassword};

    final response = CacheHelper().read(GlobalVar.isFistPassword)
        ? await apiConsumer.post(apiEndPoints.getFirstPasswordUrl(), params)
        : await apiConsumer.post(apiEndPoints.getForgotPasswordUrl(), params);
    return UserAuthModel.fromJson(response, parseNull);
  }

  @override
  Future<RegisterOrganizationDataModel> registerOrganization({RegisterOrganizationParams? registerOrganizationParams}) async {
    var params = {
      "name": registerOrganizationParams?.name,
      "userName": registerOrganizationParams?.userName,
      "password": registerOrganizationParams?.password,
      "address": registerOrganizationParams?.address,
      "email": registerOrganizationParams?.email,
      "phone": registerOrganizationParams?.phone,
    };
    final response = await apiConsumer.post(apiEndPoints.getRegisterOrganizationUrl(), params);
    return RegisterOrganizationDataModel.fromJson(response);
  }

  @override
  Future<RegisterManagementDataModel> registerManagement({RegisterManagementParams? registerManagementParams}) async {
    var params = {
      "name": registerManagementParams?.name,
      "userName": registerManagementParams?.userName,
      "password": registerManagementParams?.password,
      "address": registerManagementParams?.address,
      "email": registerManagementParams?.email,
      "phone": registerManagementParams?.phone,
    };
    final response = await apiConsumer.post(apiEndPoints.getRegisterManagementUrl(), params);
    return RegisterManagementDataModel.fromJson(response);
  }

  @override
  Future<LoginDataModel> login({LoginParams? loginParams}) async {
    var params = {
      "username": loginParams?.username,
      "password": loginParams?.password,
      /*"userFcmToken": {
        "tokenNotify": "string", // set token fcm notify
        "deviceId": "string" // set deviceid
      }*/
    };

    final response = await apiConsumer.post(apiEndPoints.getLoginUrl(), params);
    return LoginDataModel.fromJson(response);
  }

  @override
  Future<ForgotPasswordDataModel> forgotPassword({ForgotPasswordParams? forgotPasswordParams}) async {
    var params = {
      "email": forgotPasswordParams?.email,
    };

    final response = await apiConsumer.put(apiEndPoints.getForgotPasswordUrl(), params);
    return ForgotPasswordDataModel.fromJson(response);
  }

  @override
  Future<UserAuthModel> logout({LogoutParams? logoutParams}) async {
    var params = {"refreshToken": logoutParams?.refreshToken, "device_id": logoutParams?.deviceId};

    final response = await apiConsumer.post(apiEndPoints.getLogoutUrl(), params);
    return UserAuthModel.fromJson(response, parseNull);
  }

  @override
  Future<BasicResponseModel> removeUser({RemoveUserParams? params}) async {
    final response = await apiConsumer.delete(apiEndPoints.getRemoveUserUrl());
    return BasicResponseModel.fromJson(response);
  }

}
