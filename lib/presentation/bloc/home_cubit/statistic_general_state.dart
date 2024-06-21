// import 'package:equatable/equatable.dart';
//
// import '../../../data/models/home_statistic_general.dart';
//
// sealed class StatisticGeneralState extends Equatable {
//   const StatisticGeneralState();
//
//   @override
//   List<Object> get props => [];
// }
// final class StatisticGeneralInitial extends StatisticGeneralState {}
//
// final class StatisticGeneralLoading extends StatisticGeneralState {}
//
// final class StatisticGeneralSuccess extends StatisticGeneralState {
//   final StatisticGeneralModel statisticGeneralModel;
//   const StatisticGeneralSuccess({required this.statisticGeneralModel});
// }
//
// final class StatisticGeneralFailed extends StatisticGeneralState{
// final String? message;
// const StatisticGeneralFailed({required this.message});
// @override
// List<Object> get props => [];
// }