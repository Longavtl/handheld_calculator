import 'package:dartz/dartz.dart';
// import 'package:dlhp/presentation/bloc/home_cubit/user_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/helper/global_var.dart';
import '../../../core/error/failure.dart';
// import '../../../core/local/cache_helper.dart';
// import '../../../core/usecase/usecase.dart';
// import '../../../data/models/home_user_profile_model.dart';
// import '../../../domain/user_profile/usecase/user_profile_usecase.dart';
//
// class UserProfileCubit extends Cubit<UserProfileState> {
//   final GetUserProfileUseCase getUserProfileUseCase;
//
//   UserProfileCubit({required this.getUserProfileUseCase}) : super(UserProfileInitial());
//
//   // get all favorite place
//   getUserProfileUseCaseLog() async {
//     emit(UserProfileLoading());
//     Either<Failure, UserProfileModel> response = await getUserProfileUseCase(NoParams());
//     response.fold((failure) => emit(UserProfileFailed(message: failure.message)), (userProfileModel) {
//       emit(UserProfileSuccess(userProfileModel: userProfileModel));
//       final cacheHelper = CacheHelper();
//       cacheHelper.write(GlobalVar.emailKey, userProfileModel.data?.email ?? "");
//       cacheHelper.write(GlobalVar.userName, userProfileModel.data?.userName ?? "");
//       cacheHelper.write(GlobalVar.phoneKey, userProfileModel.data?.phone ?? "");
//       cacheHelper.write(GlobalVar.idInfo, userProfileModel.data?.id ?? 0);
//       cacheHelper.write(GlobalVar.accountType, userProfileModel.data?.type);
//       cacheHelper.write(GlobalVar.typeUser,userProfileModel.data?.type ?? '');
//     });
//   }
// }
