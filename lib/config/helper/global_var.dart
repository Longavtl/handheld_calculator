class GlobalVar {
  static final GlobalVar _instance = GlobalVar._internal();

  factory GlobalVar() {
    return _instance;
  }

  GlobalVar._internal();

  // Đặt các biến toàn cục bạn muốn sử dụng ở đây
  int numSelectedDate = 0;
  // Key for local cache
  static String phoneKey = "phoneKey";
  static String passKey = "passKey";
  static String accessToken = "accessToken";
  static String refreshToken = "refreshToken";
  static String otpKey = "Otp_key";
  static String isFistPassword = "isFistPassword";
  static String userInfo = "userInfo";
  static String officeId = "3815a542-3fec-47ca-a8a7-e9766b245d40";
  static String route = "route";
  static String imgAvatarTmp = "";
  static String language = "lang";
}