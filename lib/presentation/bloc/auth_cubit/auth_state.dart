part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

// check login
final class CheckLoginLoading extends AuthState {}

final class CheckLoginSuccess extends AuthState {
  final CheckLoginData checkLoginData;
  const CheckLoginSuccess({required this.checkLoginData});
}

final class CheckLoginFailed extends AuthState {
  final String? message;
  const CheckLoginFailed({required this.message});
  @override
  List<Object> get props => [];
}

// Register state
final class RegisterOrganizationInitial extends AuthState {}

final class RegisterOrganizationLoading extends AuthState {}

class RegisterOrganizationStateSuccess extends AuthState {
  final RegisterOrganizationDataModel registerOrganizationDataModel;
  const RegisterOrganizationStateSuccess({required this.registerOrganizationDataModel});
}

final class RegisterOrganizationStateFailed extends AuthState {
  final String? message;
  const RegisterOrganizationStateFailed({required this.message});
  @override
  List<Object> get props => [];
}

// Register state
final class RegisterManagementInitial extends AuthState {}

final class RegisterManagementLoading extends AuthState {}

class RegisterManagementStateSuccess extends AuthState {
  final RegisterManagementDataModel registerManagementDataModel;
  const RegisterManagementStateSuccess({required this.registerManagementDataModel});
}

final class RegisterManagementStateFailed extends AuthState {
  final String? message;
  const RegisterManagementStateFailed({required this.message});
  @override
  List<Object> get props => [];
}

// login state
final class LoginInitial extends AuthState {}

final class LoginLoading extends AuthState {}

class LoginStateSuccess extends AuthState {
  final LoginDataModel loginDataModel;
  const LoginStateSuccess({required this.loginDataModel});
}

final class LoginStateFailed extends AuthState {
  final String? message;
  const LoginStateFailed({required this.message});
  @override
  List<Object> get props => [];
}

// forgot password state
final class ForgotPasswordInitial extends AuthState {}

final class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordStateSuccess extends AuthState {
  final ForgotPasswordDataModel forgotPasswordDataModel;
  const ForgotPasswordStateSuccess({required this.forgotPasswordDataModel});
}

final class ForgotPasswordStateFailed extends AuthState {
  final String? message;
  const ForgotPasswordStateFailed({required this.message});
  @override
  List<Object> get props => [];
}