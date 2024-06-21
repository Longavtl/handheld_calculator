class Address {
  // dev env :
  // static const String domain = "https://bus-customer-dev.hoangneee.tech";
  // static const String user = "$domain/user-api/v1";
  // static const String card = "$domain/card-api/v1";
  //
  // static const String login = "$user/auth/login";
  // static const String logout = "$user/auth/logout";
  // static const String removeUser = "$user/user";
  // static const String checkLogin = "$user/auth/check-login";
  // static const String getOtp = "$user/auth/otp";
  // static const String checkOtp = "$user/auth/check-otp";
  // static const String firstPassword = "$user/auth/first-password";
  // static const String forgotPassword = "$user/auth/forgot-password";
  // static const String getProfile = "$user/user/me";
  // static const String changePass = "$user/auth/change-password";
  // static const String updateProfile = "$user/user/profile";
  //

  // static const String listCard = "$card/customer-card";
  // static const String scanQr = "$card/customer-card/scan-qr";
  // static const String cardInfo =
  //     "$card/customer-card/generate-customer-card-signed";
  // static const String getCities = "$card/cities";
  // lay routes
  // static const String getRoutes = "$card/routes/open-routes";
  // static String getDistrictById(String id) {
  //   return '$card/districts?s={"\$and":[{"city_id":{"\$eq":"$id"}}]}';
  // }

  // static String getCommuneById(String code) {
  //   return '$card/wards?s={"\$and":[{"district_code":{"\$eq":"$code"}}]}';
  // }

  // static String getAppSetting(String officeId) {
  //   return '$card/settings?office_id=$officeId';
  // }

  // static String getserviceTicker({
  //   required String usingRouteType,
  //   required String usingBy,
  // }) =>
  //     '$card/service-ticket?s={"\$and":[{"using_route_type":{"\$eq":"$usingRouteType"}},{"\$or":[{"using_by":{"\$eq":"$usingBy"}},{"using_by":{"\$eq":"FREE"}},{"using_by":{"\$eq":"GROUP"}}]},{"status":{"\$eq":"ACTIVE"}},{"type":{"\$eq":"MONTHLY"}}]}';
// nhom doi tuong
//   static String getObjectGroup = "$card/object-groups";
  // nhom doi tuong uu tien hssv cn

  // static String getPriorityObjects =
  //     '$card/object-groups?s={"\$or":[{"code":{"\$eq":"CN"}},{"code":{"\$eq":"HSSV"}}]}';
  // nhom doi tuong mien phi
  // static String getFreeObjects =
  //     '$card/object-groups?s={"type":{"\$eq":"FREE"}}';
  // dang ky
  // static String getSchools = "$card/schools";
  // static String getIndustrialArea = '$card/industrial-areas';
  // dang ky
  // static String regisRequestTicket = "$card/customer-request";
  // upload card
  // static String pictureCard = "$card/customer-card/picture-card";
  // gia han ve thang
  // static String getRenewInfor(String id) {
  //   return '$card/order/renew/$id';
  // }

  // static String requestRenewMonthTicket() {
  //   return '$card/order/renew';
  // }
}
