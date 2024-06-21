class UserProfileModel {
  String? avatar;
  String? language;
  String? idNo;
  String? email;
  String? fullName;
  String? phone;
  int? type;
  String? dateOfBirth;

  UserProfileModel(
      {this.avatar,
        this.language,
        this.idNo,
        this.email,
        this.fullName,
        this.phone,
        this.type,
        this.dateOfBirth});

  UserProfileModel copyWith(
      {String? avatar,
        String? language,
        String? idNo,
        String? email,
        String? fullName,
        String? phone,
        int? type,
        String? dateOfBirth}) =>
      UserProfileModel(
        avatar: avatar ?? this.avatar,
        language: language ?? this.language,
        idNo: idNo ?? this.idNo,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        type: type ?? this.type,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      );

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    language = json['language'];
    idNo = json['idNo'];
    email = json['email'];
    phone = json['phone'];
    fullName = json['fullName'];
    type = json['type'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'language': language,
      'idNo': idNo,
      'email': email,
      'phone': phone,
      'fullName': fullName,
      'type': type,
      'dateOfBirth': dateOfBirth,
    }..removeWhere((key, value) => value == null);
  }

}
