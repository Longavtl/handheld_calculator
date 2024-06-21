import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/local/user_profile_model.dart';
import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class BasicParams extends Equatable {
  final String value;
  final String endUrl;

  const BasicParams({required this.value, required this.endUrl});

  @override
  List<Object?> get props => [value];
}

// Auth
class CheckLoginParams extends Equatable {
  final String phone;

  const CheckLoginParams({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class RegisterOrganizationParams extends Equatable {
  final String name;
  final String password;
  final String userName;
  final String address;
  final String email;
  final String phone;

  const RegisterOrganizationParams({
    required this.name,
    required this.password,
    required this.userName,
    required this.address,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, password, userName, address, email, phone];
}

class RegisterManagementParams extends Equatable {
  final String name;
  final String password;
  final String userName;
  final String address;
  final String detailedAddress;
  final String ward;
  final String district;
  final String conscious;
  final String email;
  final String phone;
  final String lawRepresentative;
  final String ownerUnit;
  final String operationType;
  final String website;
  final String businessNumber;
  final String tax;
  final String businessLicense;
  final String date;
  final UploadFile uploadFile;

  const RegisterManagementParams({
    required this.name,
    required this.password,
    required this.userName,
    required this.address,
    required this.detailedAddress,
    required this.ward,
    required this.district,
    required this.conscious,
    required this.email,
    required this.phone,
    required this.lawRepresentative,
    required this.ownerUnit,
    required this.operationType,
    required this.website,
    required this.businessNumber,
    required this.tax,
    required this.businessLicense,
    required this.date,
    required this.uploadFile,
  });

  @override
  List<Object?> get props => [
    name,
    password,
    userName,
    address,
    detailedAddress,
    ward,
    district,
    conscious,
    email,
    phone,
    lawRepresentative,
    ownerUnit,
    operationType,
    website,
    businessNumber,
    tax,
    businessLicense,
    date,
    uploadFile,
  ];
}

class UploadFile extends Equatable {
  final String url;
  final String fileName;

  const UploadFile({
    required this.url,
    required this.fileName,
  });

  @override
  List<Object?> get props => [url, fileName];
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({required this.email});

  @override
  List<Object?> get props => [email];
}

class CheckOtpParams extends Equatable {
  final String phone;
  final String otp;

  const CheckOtpParams({required this.phone, required this.otp});

  @override
  List<Object?> get props => [phone, otp];
}

class FirstPassParams extends Equatable {
  final String phone;
  final String newPassword;

  const FirstPassParams({required this.phone, required this.newPassword});

  @override
  List<Object?> get props => [phone, newPassword];
}

class ChangePassParams extends Equatable {
  final String newPassword;
  final String password;

  const ChangePassParams({required this.newPassword, required this.password});

  @override
  List<Object?> get props => [newPassword, password];
}

class UpdateProfileParams extends Equatable {
  final UserProfileModel userProfileModel;

  const UpdateProfileParams({required this.userProfileModel});

  @override
  List<Object?> get props => [userProfileModel];
}

class UploadAvatarParams extends Equatable {
  final String imgPath;
  final String accessToken;

  const UploadAvatarParams({required this.imgPath, required this.accessToken});

  @override
  List<Object?> get props => [imgPath, accessToken];
}

class LogoutParams extends Equatable {
  final String refreshToken;
  final String deviceId;

  const LogoutParams({required this.refreshToken, required this.deviceId});

  @override
  List<Object?> get props => [refreshToken, deviceId];
}

class RemoveUserParams extends Equatable {
  final String accessToken;

  const RemoveUserParams({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}
