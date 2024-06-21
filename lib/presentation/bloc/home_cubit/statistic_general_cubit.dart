// import 'package:dartz/dartz.dart';
// import 'package:dlhp/presentation/bloc/home_cubit/statistic_general_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/error/failure.dart';
// import '../../../core/usecase/usecase.dart';
// import '../../../data/models/home_statistic_general.dart';
// import '../../../domain/statistic_general/usecase/statistic_general_usecase.dart';
//
// class StatisticGeneralCubit extends Cubit<StatisticGeneralState> {
//   final GetAllStatisticGeneralUseCase getAllStatisticGeneralUseCase;
//
//   StatisticGeneralCubit({required this.getAllStatisticGeneralUseCase}) : super(StatisticGeneralInitial());
//
//   // get all favorite place
//   doGetAllStatisticGeneral() async {
//     emit(StatisticGeneralLoading());
//     Either<Failure, StatisticGeneralModel> response = await getAllStatisticGeneralUseCase(NoParams());
//     response.fold((failure) => emit(StatisticGeneralFailed(message: failure.message)), (statisticGeneralPlaceModel) {
//       emit(StatisticGeneralSuccess(statisticGeneralModel: statisticGeneralPlaceModel));
//     });
//   }
// }
