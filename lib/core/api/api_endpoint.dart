class ApiEndPoints {
  // bool enableRemoteConfig = true; // Set for prod
  bool enableRemoteConfig = false; // Set false for dev or local
  ApiEndPoints();

  static const String baseUrl = 'https://apidlhp.teracom.vn/api/';

  // API PROD
  // static const String baseUrl = 'https://customer.vnpass.vn';
  

  // static const String cusCardUrl = "$cardUrl/customer-card";

  String setBaseUrl(String url) {
    // DEV
    return '$baseUrl$url';
  }

  // Auth
  static const String login = "auth/login";

  String getLoginUrl() {
    return setBaseUrl(login);
  }

  static const String registerOrganization = "auth/createOrganization";

  String getRegisterOrganizationUrl() {
    return setBaseUrl(registerOrganization);
  }

  static const String registerManagement = "auth/createManagement";

  String getRegisterManagementUrl() {
    return setBaseUrl(registerManagement);
  }

  static const String checkLogin = "/auth/check-login";

  String getCheckLoginUrl() {
    return setBaseUrl(checkLogin);
  }

  static const String forgotPassword = "auth/forgotPassword";

  String getForgotPasswordUrl() {
    return setBaseUrl(forgotPassword);
  }

  static const String logout = "/auth/logout";

  String getLogoutUrl() {
    return setBaseUrl(logout);
  }

  static const String changePass = "/auth/change-password";

  String getChangePassUrl() {
    return setBaseUrl(changePass);
  }

  static const String getOtp = "/auth/otp";

  String getAuthOtpUrl() {
    return setBaseUrl(getOtp);
  }

  static const String checkOtp = "/auth/check-otp";

  String getCheckOtpUrl() {
    return setBaseUrl(checkOtp);
  }

  static const String firstPassword = "/auth/first-password";

  String getFirstPasswordUrl() {
    return setBaseUrl(firstPassword);
  }


  // End Auth
  // ======

  // User
  static const String getProfile = "/user/me";

  String getProfileUrl() {
    return setBaseUrl(getProfile);
  }

  static const String updateProfile = "/user/profile";

  String getUpdateProfileUrl() {
    return setBaseUrl(updateProfile);
  }

  static const String removeUser = "/user";

  String getRemoveUserUrl() {
    return setBaseUrl(removeUser);
  }
}