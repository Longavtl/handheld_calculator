// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/error/failure.dart';
// import '../../../core/usecase/usecase.dart';
// import '../../../data/models/home_access_log_model.dart';
// import '../../../domain/access_log/usecase/access_log_usecase.dart';
// import 'access_log_state.dart';
//
// class AccessLogCubit extends Cubit<AccessLogState> {
//   final GetAllAccessLogUseCase getAllAccessLogUseCase;
//
//   AccessLogCubit({required this.getAllAccessLogUseCase}) : super(AccessLogInitial());
//
//   // get all favorite place
//   doGetAllAccessLog() async {
//     emit(AccessLogLoading());
//     Either<Failure, AccessLogModel> response = await getAllAccessLogUseCase(NoParams());
//     response.fold((failure) => emit(AccessLogFailed(message: failure.message)), (accessLogPlaceModel) {
//       emit(AccessLogSuccess(accessLogModel: accessLogPlaceModel));
//     });
//   }
// }
