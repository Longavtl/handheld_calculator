import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/models/basic_response_model.dart';
import '../../../data/models/user_auth_model.dart';
import '../repository/user_auth_repository.dart';


class UserAuthUseCase implements UseCase<UserAuthModel, CheckLoginParams> {
  final UserAuthRepository authRepository;

  UserAuthUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserAuthModel>> call(CheckLoginParams params) =>
      authRepository.checkLogin(params);
}

class OtpUseCase implements UseCase<UserAuthModel, CheckLoginParams> {
  final UserAuthRepository authRepository;

  OtpUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserAuthModel>> call(CheckLoginParams params) =>
      authRepository.getOtp(params);
}

class CheckOtpUseCase implements UseCase<UserAuthModel, CheckOtpParams> {
  final UserAuthRepository authRepository;

  CheckOtpUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserAuthModel>> call(CheckOtpParams params) =>
      authRepository.checkOtp(params);
}

class SetPasswordUseCase implements UseCase<UserAuthModel, FirstPassParams> {
  final UserAuthRepository authRepository;

  SetPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserAuthModel>> call(FirstPassParams params) =>
      authRepository.setPassword(params);
}

class RegisterOrganizationUseCase implements UseCase<RegisterOrganizationDataModel, RegisterOrganizationParams> {
  final UserAuthRepository authRepository;

  RegisterOrganizationUseCase(this.authRepository);

  @override
  Future<Either<Failure, RegisterOrganizationDataModel>> call(RegisterOrganizationParams params) =>
      authRepository.doRegisterOrganization(params);
}

class RegisterManagementUseCase implements UseCase<RegisterManagementDataModel, RegisterManagementParams> {
  final UserAuthRepository authRepository;

  RegisterManagementUseCase(this.authRepository);

  @override
  Future<Either<Failure, RegisterManagementDataModel>> call(RegisterManagementParams params) =>
      authRepository.doRegisterManagement(params);
}

class LoginUseCase implements UseCase<LoginDataModel, LoginParams> {
  final UserAuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, LoginDataModel>> call(LoginParams params) =>
      authRepository.doLogin(params);
}

class ForgotPasswordUseCase implements UseCase<ForgotPasswordDataModel, ForgotPasswordParams> {
  final UserAuthRepository authRepository;

  ForgotPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, ForgotPasswordDataModel>> call(ForgotPasswordParams params) =>
      authRepository.doForgotPassword(params);
}

class LogoutUseCase implements UseCase<UserAuthModel, LogoutParams> {
  final UserAuthRepository authRepository;
  LogoutUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserAuthModel>> call(LogoutParams params) =>
      authRepository.doLogout(params);
}

class RemoveUserUseCase implements UseCase<BasicResponseModel, RemoveUserParams> {
  final UserAuthRepository authRepository;
  RemoveUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, BasicResponseModel>> call(RemoveUserParams params) =>
      authRepository.removeUser(params);
}

