import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/helper/global_var.dart';
import '../../../core/error/failure.dart';
import '../../../core/local/cache_helper.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/models/user_auth_model.dart';
import '../../../domain/auth/usecase/user_auth_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserAuthUseCase userAuthUseCase;
  final OtpUseCase otpUseCase;
  final CheckOtpUseCase checkOtpUseCase;
  final SetPasswordUseCase setPasswordUseCase;
  final LoginUseCase loginUseCase;
  final RegisterOrganizationUseCase registerOrganizationUseCase;
  final RegisterManagementUseCase registerManagementUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final LogoutUseCase logoutUseCase;
  final RemoveUserUseCase removeUserUseCase;

  AuthCubit({
    required this.userAuthUseCase,
    required this.otpUseCase,
    required this.checkOtpUseCase,
    required this.setPasswordUseCase,
    required this.loginUseCase,
    required this.registerOrganizationUseCase,
    required this.registerManagementUseCase,
    required this.removeUserUseCase,
    required this.logoutUseCase,
    required this.forgotPasswordUseCase,
  }) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  doLogin(String userName, String password) async {
    emit(LoginLoading());

    Either<Failure, LoginDataModel> response = await loginUseCase(LoginParams(username: userName, password: password));

    response.fold(
      (failure) => emit(LoginStateFailed(message: failure.message)),
      (loginDataModel) {
        if (loginDataModel.status == 1) {
          final cacheHelper = CacheHelper();
          cacheHelper.write(GlobalVar.accessToken, loginDataModel.token);
          cacheHelper.remove(GlobalVar.passKey);
          cacheHelper.write(GlobalVar.passKey, password);
          emit(LoginStateSuccess(loginDataModel: loginDataModel));
        } else {
          emit(LoginStateFailed(message: 'Login failed: ${loginDataModel.errorMessage ?? "Something went wrong"}'));
        }
      },
    );
  }

  doRegisterOrganization(
    String name,
    String userName,
    String password,
    String address,
    String email,
    String phone,
  ) async {
    emit(LoginLoading());

    Either<Failure, RegisterOrganizationDataModel> response = await registerOrganizationUseCase(
        RegisterOrganizationParams(
            name: name, userName: userName, password: password, address: address, email: email, phone: phone));

    response.fold(
      (failure) => emit(RegisterOrganizationStateFailed(message: failure.message)),
      (registerOrganizationDataModel) {
        if (registerOrganizationDataModel.status == 1) {
          emit(RegisterOrganizationStateSuccess(registerOrganizationDataModel: registerOrganizationDataModel));
        } else {
          emit(RegisterOrganizationStateFailed(
              message: 'Register failed: ${registerOrganizationDataModel.data ?? "Something went wrong"}'));
        }
      },
    );
  }

  doRegisterManagement(
    String name,
    String userName,
    String password,
    String address,
    String email,
    String phone,
    String detailedAddress,
    String ward,
    String district,
    String conscious,
    String lawRepresentative,
    String ownerUnit,
    String operationType,
    String website,
    String businessNumber,
    String tax,
    String date,
    String businessLicense,
    UploadFile uploadFile,
  ) async {
    emit(LoginLoading());

    Either<Failure, RegisterManagementDataModel> response = await registerManagementUseCase(RegisterManagementParams(
        name: name,
        userName: userName,
        password: password,
        address: address,
        email: email,
        phone: phone,
        detailedAddress: '',
        ward: '',
        district: '',
        conscious: '',
        lawRepresentative: '',
        ownerUnit: '',
        operationType: '',
        website: '',
        businessNumber: '',
        tax: '',
        businessLicense: '',
        date: '',
        uploadFile: uploadFile));

    response.fold(
      (failure) => emit(RegisterManagementStateFailed(message: failure.message)),
      (registerManagementDataModel) {
        if (registerManagementDataModel.status == 1) {
          emit(RegisterManagementStateSuccess(registerManagementDataModel: registerManagementDataModel));
        } else {
          emit(RegisterManagementStateFailed(
              message: 'Login failed: ${registerManagementDataModel.error ?? "Something went wrong"}'));
        }
      },
    );
  }

  doForgotPassword(String email) async {
    emit(ForgotPasswordLoading());

    Either<Failure, ForgotPasswordDataModel> response =
        await forgotPasswordUseCase(ForgotPasswordParams( email: email));

    response.fold(
      (failure) => emit(ForgotPasswordStateFailed(message: failure.message)),
      (forgotPasswordDataModel) {
        if (forgotPasswordDataModel.status == 1) {
          emit(ForgotPasswordStateSuccess(forgotPasswordDataModel: forgotPasswordDataModel));
        } else {
          emit(ForgotPasswordStateFailed(
              message: 'ForgotPassword failed: ${forgotPasswordDataModel.errorMessage ?? "Something went wrong"}'));
        }
      },
    );
  }
}
