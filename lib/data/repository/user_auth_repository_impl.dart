import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../config/helper/network_info.dart';
import '../../core/error/error_handler.dart';
import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/auth/repository/user_auth_repository.dart';
import '../data_sources/remote/auth/auth_remote_datasource.dart';
import '../models/basic_response_model.dart';
import '../models/user_auth_model.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authRemoteDataSource;

  UserAuthRepositoryImpl(
      {required this.networkInfo, required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserAuthModel>> checkLogin(
      CheckLoginParams checkLoginParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource = await authRemoteDataSource.checkLogin(
            phone: checkLoginParams.phone);
        if (remoteDataSource.success!) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.message.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  // otp
  @override
  Future<Either<Failure, UserAuthModel>> getOtp(CheckLoginParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource =
        await authRemoteDataSource.getOtp(phone: params.phone);
        if (remoteDataSource.success!) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.message.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  // check otp
  @override
  Future<Either<Failure, UserAuthModel>> checkOtp(CheckOtpParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource =
        await authRemoteDataSource.checkOtp(otpParams: params);
        if (remoteDataSource.success!) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.message.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAuthModel>> setPassword(
      FirstPassParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource =
        await authRemoteDataSource.setPassword(passParams: params);
        if (remoteDataSource.success!) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.message.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterOrganizationDataModel>> doRegisterOrganization(RegisterOrganizationParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource = await authRemoteDataSource.registerOrganization(registerOrganizationParams: params);
        debugPrint("object ${remoteDataSource.data}");
        if (remoteDataSource.status == 1) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.data.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterManagementDataModel>> doRegisterManagement(RegisterManagementParams params) async{
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource = await authRemoteDataSource.registerManagement(registerManagementParams: params);
        debugPrint("object ${remoteDataSource.data}");
        if (remoteDataSource.status == 1) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.error.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  // login
  @override
  Future<Either<Failure, LoginDataModel>> doLogin(LoginParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource = await authRemoteDataSource.login(loginParams: params);
        debugPrint("object ${remoteDataSource.token}");
        if (remoteDataSource.status == 1) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.errorMessage.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordDataModel>> doForgotPassword(ForgotPasswordParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource =
        await authRemoteDataSource.forgotPassword(forgotPasswordParams: params);
        print('removeUser');
        print(remoteDataSource);
        if (remoteDataSource.status == 1) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.errorMessage.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAuthModel>> doLogout(LogoutParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource =
        await authRemoteDataSource.logout(logoutParams: params);
        if (remoteDataSource.success!) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.message.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, BasicResponseModel>> removeUser(RemoveUserParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource =
        await authRemoteDataSource.removeUser();
        print('removeUser');
        print(remoteDataSource);
        if (remoteDataSource.status == 200) {
          return Right(remoteDataSource);
        } else {
          return Left(Failure(400, remoteDataSource.error.toString()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }



}
