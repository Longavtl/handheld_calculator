
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:handheld_calculator/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/helper/network_info.dart';
import 'core/api/api_consumer.dart';
import 'core/api/api_endpoint.dart';
import 'core/api/debug_log_interceptor.dart';
import 'core/api/dio_consumer.dart';
import 'data/data_sources/remote/auth/auth_remote_datasource.dart';
import 'data/repository/user_auth_repository_impl.dart';
import 'domain/auth/repository/user_auth_repository.dart';
import 'domain/auth/usecase/user_auth_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Blocs
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(
        userAuthUseCase: sl(),
        otpUseCase: sl(),
        checkOtpUseCase: sl(),
        setPasswordUseCase: sl(),
        loginUseCase: sl(),
        registerOrganizationUseCase: sl(),
        removeUserUseCase: sl(),
        logoutUseCase: sl(),
        registerManagementUseCase: sl(),
        forgotPasswordUseCase: sl(),
      ));

  //UseCases
  sl.registerLazySingleton<UserAuthUseCase>(() => UserAuthUseCase(sl()));
  sl.registerLazySingleton<OtpUseCase>(() => OtpUseCase(sl()));
  sl.registerLazySingleton<CheckOtpUseCase>(() => CheckOtpUseCase(sl()));
  sl.registerLazySingleton<SetPasswordUseCase>(() => SetPasswordUseCase(sl()));
  sl.registerLazySingleton<RegisterOrganizationUseCase>(() => RegisterOrganizationUseCase(sl()));
  sl.registerLazySingleton<RegisterManagementUseCase>(() => RegisterManagementUseCase(sl()));
  sl.registerLazySingleton<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()));
  sl.registerLazySingleton<RemoveUserUseCase>(() => RemoveUserUseCase(sl()));

  //** Repository */
  sl.registerLazySingleton<UserAuthRepository>(
      () => UserAuthRepositoryImpl(networkInfo: sl(), authRemoteDataSource: sl()));

  ///*** Data source */
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        apiConsumer: sl(),
        apiEndPoints: sl(),
      ));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

  sl.registerLazySingleton(() => ApiEndPoints());
  // cached
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => LogInterceptor(
      request: true, requestBody: true, requestHeader: true, responseBody: true, responseHeader: true, error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => DebugLogInterceptor());
  // Dio
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dioClient: sl()));
}
