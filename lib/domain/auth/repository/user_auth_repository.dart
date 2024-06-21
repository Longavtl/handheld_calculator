import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/models/basic_response_model.dart';
import '../../../data/models/user_auth_model.dart';


abstract class UserAuthRepository {
  Future<Either<Failure, UserAuthModel>> checkLogin(CheckLoginParams params);
  Future<Either<Failure, UserAuthModel>> getOtp(CheckLoginParams params);
  Future<Either<Failure, LoginDataModel>> doLogin(LoginParams params);
  Future<Either<Failure, RegisterOrganizationDataModel>> doRegisterOrganization(RegisterOrganizationParams params);
  Future<Either<Failure, RegisterManagementDataModel>> doRegisterManagement(RegisterManagementParams params);
  Future<Either<Failure, ForgotPasswordDataModel>> doForgotPassword(ForgotPasswordParams params);
  Future<Either<Failure, UserAuthModel>> doLogout(LogoutParams params);
  Future<Either<Failure, UserAuthModel>> checkOtp(CheckOtpParams params);
  Future<Either<Failure, UserAuthModel>> setPassword(FirstPassParams params);
  Future<Either<Failure, BasicResponseModel>> removeUser(RemoveUserParams params);
}